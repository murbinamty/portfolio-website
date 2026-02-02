# EDI Integration Solutions

## Overview
Production-ready Electronic Data Interchange (EDI) integration solutions for global supply chain operations, supporting multiple EDI standards and trading partners.

## Supported EDI Standards

### ANSI X12 (North America)
- **810** - Invoice
- **850** - Purchase Order
- **855** - Purchase Order Acknowledgment
- **856** - Advance Ship Notice (ASN)
- **997** - Functional Acknowledgment
- **820** - Payment Order/Remittance Advice
- **940** - Warehouse Shipping Order
- **945** - Warehouse Shipping Advice

### EDIFACT (International)
- **ORDERS** - Purchase Order
- **ORDRSP** - Purchase Order Response
- **DESADV** - Despatch Advice
- **INVOIC** - Invoice
- **CONTRL** - Syntax and Service Report Message

### Custom Formats
- Flat file translations (CSV, Fixed-width)
- XML transformations
- JSON to EDI conversions
- Partner-specific formats

## Architecture

```
EDI Flow Architecture
═══════════════════════

┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   Trading   │ AS2/FTP │   Sterling   │  Map    │  Backend    │
│   Partner   │────────→│    B2Bi      │─────────→│   Systems   │
│             │         │              │         │  (SAP/ERP)  │
└─────────────┘         └──────────────┘         └─────────────┘
                             ↓
                        ┌────────────┐
                        │ Monitoring │
                        │  & Alerts  │
                        └────────────┘
```

## Key Components

### 1. Inbound Processing
**Trading Partner → Internal Systems**

```
Reception → Validation → Translation → Routing → Backend Integration
    ↓           ↓            ↓          ↓              ↓
  AS2/FTP   Compliance   Map Engine   Rules     SAP/ERP/DB
            Check        (MXL)        Engine
```

**Features:**
- Multi-protocol support (AS2, SFTP, HTTPS, MQ)
- EDI standards compliance validation
- Duplicate detection and prevention
- Acknowledgment generation (997/CONTRL)
- Error handling and retry logic

### 2. Outbound Processing
**Internal Systems → Trading Partner**

```
Trigger → Data Extract → Translation → Envelope → Transmission
   ↓           ↓             ↓          ↓            ↓
Database   Transform    Map Engine   Add ISA/GS   AS2/SFTP
Event      to EDI       (MXL)        Headers      Send
```

**Features:**
- Event-driven triggers
- Batching and grouping
- Control number management
- Partner-specific formatting
- Delivery confirmation

### 3. Monitoring & Reporting
- Real-time transaction monitoring
- SLA compliance tracking
- Exception handling
- Business metrics dashboard
- Audit trail and compliance reporting

## Sample Implementations

### 850 Purchase Order (Inbound)
**Walmart → Kellanova Flow**

```xml
<!-- Business Process: Process_850_Inbound -->
<Process>
    <Receive>
        <!-- Receive EDI 850 from AS2 -->
        <AS2Receive mailbox="/walmart/inbound"/>
    </Receive>
    
    <Validate>
        <!-- Validate against X12 4010 schema -->
        <EDIValidation standard="X12" version="4010" transaction="850"/>
    </Validate>
    
    <Transform>
        <!-- Map to internal XML format -->
        <MapExecution map="EDI_850_4010_to_Internal_PO.mxl"/>
    </Transform>
    
    <Route>
        <!-- Route to SAP for order creation -->
        <SAPAdapter>
            <IDOC type="ORDERS05"/>
        </SAPAdapter>
    </Route>
    
    <Acknowledge>
        <!-- Generate 997 acknowledgment -->
        <Generate997 sendTo="walmart"/>
    </Acknowledge>
</Process>
```

**Map Logic (Simplified):**
```
PO02*00*0001234567 → <PurchaseOrder><PoNumber>0001234567</PoNumber>
REF*DP*STORE-001   → <Reference><StoreId>STORE-001</StoreId>
PID05*Description  → <ItemDescription>Description</ItemDescription>
```

### 810 Invoice (Outbound)
**Kellanova → Customer Flow**

```xml
<!-- Business Process: Generate_810_Invoice -->
<Process>
    <Trigger>
        <!-- Watch for billing events -->
        <DatabaseWatch table="INVOICES" status="READY_TO_SEND"/>
    </Trigger>
    
    <Extract>
        <!-- Extract invoice data -->
        <SQLQuery>
            SELECT invoice_num, customer, items, totals 
            FROM invoices WHERE id = ?
        </SQLQuery>
    </Extract>
    
    <Transform>
        <!-- Map to EDI 810 format -->
        <MapExecution map="Internal_Invoice_to_EDI_810_5010.mxl"/>
    </Transform>
    
    <Envelope>
        <!-- Add ISA/GS headers with control numbers -->
        <EDIEnvelope partner="TARGET_CUSTOMER"/>
    </Envelope>
    
    <Send>
        <!-- Transmit via AS2 -->
        <AS2Send partner="TARGET_CUSTOMER" 
                 requestMDN="true"
                 signed="true"/>
    </Send>
</Process>
```

## Technical Implementation

### Map Development (MXL)
**Sample Map Structure:**
```xml
<Map name="EDI_850_to_SAP_ORDERS">
    <!-- Input: EDI X12 850 -->
    <Input type="X12" version="004010" transaction="850"/>
    
    <!-- Output: SAP IDoc ORDERS05 -->
    <Output type="IDoc" version="ORDERS05"/>
    
    <Transformation>
        <!-- Header Mapping -->
        <Rule>
            <Source>BEG03</Source> <!-- PO Number -->
            <Target>E1EDK01/BELNR</Target>
            <Function>trim()</Function>
        </Rule>
        
        <!-- Date Conversion -->
        <Rule>
            <Source>BEG05</Source> <!-- CCYYMMDD -->
            <Target>E1EDK01/DATUM</Target>
            <Function>formatDate('CCYYMMDD', 'YYYYMMDD')</Function>
        </Rule>
        
        <!-- Line Items Loop -->
        <Loop source="PO1" target="E1EDP01">
            <Rule>
                <Source>PO101</Source> <!-- Line Number -->
                <Target>POSEX</Target>
            </Rule>
            <Rule>
                <Source>PO102</Source> <!-- Quantity -->
                <Target>MENGE</Target>
            </Rule>
            <Rule>
                <Source>PO107</Source> <!-- Product ID -->
                <Target>IDTNR</Target>
            </Rule>
        </Loop>
    </Transformation>
</Map>
```

### Error Handling
```python
# Error handling strategy
def process_edi_message(message):
    try:
        # Validate syntax
        validate_edi_syntax(message)
        
        # Validate business rules
        validate_business_rules(message)
        
        # Process transaction
        result = execute_map(message)
        
        # Generate acknowledgment
        generate_997(message, status='A')  # Accepted
        
        return result
        
    except EDISyntaxError as e:
        # Send rejection (997 with AK5 = 'R')
        generate_997(message, status='R', error=str(e))
        notify_support(message, e)
        
    except BusinessRuleError as e:
        # Send acceptance with errors (997 with AK5 = 'E')
        generate_997(message, status='E', error=str(e))
        route_to_exception_queue(message, e)
        
    except Exception as e:
        # System error - retry
        log_error(message, e)
        schedule_retry(message, delay=300)
```

### Partner Configuration
```json
{
    "partner": {
        "name": "Walmart",
        "qualifier": "ZZ",
        "id": "WALMART001",
        "protocols": {
            "as2": {
                "url": "https://as2.walmart.com/receive",
                "certificate": "walmart_cert.pem",
                "mdn_required": true,
                "signed": true,
                "encrypted": true
            },
            "sftp": {
                "host": "sftp.walmart.com",
                "port": 22,
                "username": "kellanova",
                "inbound_path": "/outbound/kellanova",
                "outbound_path": "/inbound/kellanova"
            }
        },
        "transactions": {
            "inbound": ["850", "860", "865"],
            "outbound": ["810", "856", "997"]
        },
        "edi_version": "004010",
        "separators": {
            "segment": "~",
            "element": "*",
            "subelement": ":"
        },
        "control_numbers": {
            "isa": "sequential",
            "gs": "sequential",
            "st": "sequential",
            "range": "000000001-999999999"
        }
    }
}
```

## Monitoring & Analytics

### Dashboard Metrics
```javascript
// Real-time EDI metrics
{
    "daily_transactions": {
        "inbound": {
            "total": 1247,
            "success": 1235,
            "errors": 12,
            "success_rate": "99.04%"
        },
        "outbound": {
            "total": 893,
            "success": 893,
            "errors": 0,
            "success_rate": "100%"
        }
    },
    "by_transaction": {
        "850": { "count": 456, "avg_time": "2.3s" },
        "810": { "count": 523, "avg_time": "1.8s" },
        "856": { "count": 370, "avg_time": "3.1s" }
    },
    "by_partner": {
        "Walmart": { "volume": 412, "sla_met": "99.8%" },
        "Target": { "volume": 278, "sla_met": "100%" },
        "Kroger": { "volume": 234, "sla_met": "99.2%" }
    }
}
```

### Alert Configuration
```yaml
alerts:
  - name: High Error Rate
    condition: error_rate > 5%
    window: 15min
    notify: [edi-team@kellanova.com, pagerduty]
    
  - name: SLA Breach
    condition: processing_time > sla_threshold
    partner: any
    notify: [operations-manager]
    
  - name: Control Number Gap
    condition: missing_sequence_number
    severity: high
    action: [alert, auto-investigate]
```

## Production Statistics

### Volume Metrics
- **Daily Transactions**: ~2,000 EDI messages
- **Monthly Volume**: 45,000+ transactions
- **Peak Processing**: 500 transactions/hour
- **Partners**: 50+ active trading partners
- **Supported Formats**: 15 different EDI transactions

### Performance
- **Average Processing Time**: 2.5 seconds per message
- **SLA Compliance**: 99.5%
- **Availability**: 99.9% uptime
- **Error Rate**: < 1% (mostly partner-side issues)

### Business Impact
- **$50M+ Annual Value** processed through EDI
- **Zero Manual Intervention** for 98% of transactions
- **24/7 Automated Processing**
- **Real-time Order Fulfillment**

## Compliance & Security

### Standards Compliance
✅ ANSI X12 compliance  
✅ UN/EDIFACT compliance  
✅ HIPAA (for healthcare partners)  
✅ PCI DSS (for payment transactions)  
✅ AS2 RFC 4130  

### Security Features
- 🔒 TLS 1.2+ encryption
- 📜 Digital signatures (X.509 certificates)
- 🔐 Secure key management
- 📝 Comprehensive audit logging
- 🛡️ Data masking for sensitive information

## Troubleshooting Guide

### Common Issues

**Issue: 997 Rejection (AK901=R)**
```
Cause: Syntax error in EDI file
Solution: 
1. Check AK304 for error code
2. Validate against EDI standard
3. Review partner specifications
4. Test with sample files
```

**Issue: Duplicate Processing**
```
Cause: Control number not tracked
Solution:
1. Implement ISA/GS/ST number validation
2. Store processed control numbers
3. Add duplicate detection logic
4. Configure retention period
```

**Issue: Timeout on Large Files**
```
Cause: Map processing exceeds timeout
Solution:
1. Optimize map performance
2. Increase timeout settings
3. Implement batch processing
4. Consider async processing
```

## Best Practices

### Map Development
1. **Use standard libraries** for common transformations
2. **Validate at every step** (input, transformation, output)
3. **Handle null values** gracefully
4. **Log transformation details** for debugging
5. **Test with production data** samples

### Performance Optimization
1. **Batch processing** for high volumes
2. **Parallel processing** for independent transactions
3. **Connection pooling** for database operations
4. **Caching** for frequently accessed data
5. **Async processing** for non-time-critical operations

### Monitoring
1. **Set up real-time alerts** for failures
2. **Track SLA metrics** per partner
3. **Monitor control number sequences**
4. **Review error patterns** regularly
5. **Generate compliance reports** monthly

## Future Enhancements
- [ ] API-based EDI (REST/JSON)
- [ ] Blockchain for transaction verification
- [ ] ML-based error prediction
- [ ] Self-service partner onboarding portal
- [ ] Advanced analytics and BI dashboards

## Related Projects
- [B2Bi Map Testing Framework](../b2bi-maptest/)
- [B2Bi DevOps Automation](../b2bi-devops/)

## Resources
- [EDI Standards Guide](./docs/edi-standards.md)
- [Partner Onboarding](./docs/partner-onboarding.md)
- [Troubleshooting Guide](./docs/troubleshooting.md)
- [Map Templates](./templates/)

## Author
**Mario Urbina**  
Senior B2B Integration Engineer  
mario.urbina@kellanova.com

---
*Last Updated: February 2026*
