# Mario Urbina - Portfolio Setup Instructions

## Quick Start

You now have a complete portfolio website ready to deploy! Here's what has been created:

### 📁 File Structure
```
portfolio-website/
├── index.html              # Main website
├── css/
│   └── style.css          # Styles
├── js/
│   └── main.js            # JavaScript
├── projects/              # Project documentation
│   ├── b2bi-maptest/
│   ├── b2bi-devops/
│   ├── edi-integration/
│   └── copilot-integration/
├── README.md              # Portfolio overview
├── .gitignore            # Git ignore rules
├── DEPLOYMENT.md         # Deployment instructions
└── SETUP.md              # This file
```

## Next Steps

### 1. Review Your Website Locally
Open `index.html` in your browser to preview the website:
```powershell
# Open in default browser
Start-Process "c:\AI_EDI\portfolio-website\index.html"
```

### 2. Customize Content

#### Update Personal Information
Edit `index.html`:
- LinkedIn URL (line ~207)
- GitHub URL (line ~211)
- Email address (lines throughout)
- Add your photo if desired

#### Add Your Resume
Copy your resume PDF:
```powershell
Copy-Item "c:\AI_EDI\Mario_Urbina_26A.pdf" "c:\AI_EDI\portfolio-website\"
```

### 3. Customize Projects
Review and update project documentation in `projects/` folders:
- Add screenshots
- Update technical details
- Add specific metrics from your work
- Include code samples

### 4. Deploy to GitHub

#### Option A: GitHub Pages (Recommended)
```powershell
# Navigate to folder
cd c:\AI_EDI\portfolio-website

# Initialize Git
git init
git add .
git commit -m "Initial commit: Professional portfolio"

# Create repository on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/portfolio.git
git branch -M main
git push -u origin main

# Enable GitHub Pages in repository settings
```

#### Option B: Netlify
1. Sign up at https://netlify.com
2. Drag and drop the `portfolio-website` folder
3. Your site goes live instantly!

### 5. Share Your Portfolio

Once deployed, share your portfolio:
- Update LinkedIn profile with website URL
- Add to resume
- Include in email signature
- Share with recruiters and hiring managers

## Customization Guide

### Change Color Scheme
Edit `css/style.css` variables (lines 5-15):
```css
:root {
    --primary-color: #2563eb;    /* Main color */
    --secondary-color: #1e40af;  /* Accent color */
    --accent-color: #3b82f6;     /* Highlight color */
}
```

### Add More Projects
1. Create new folder in `projects/`
2. Add README.md with project details
3. Add project card to `index.html`:
```html
<div class="project-card">
    <div class="project-icon">🎯</div>
    <h3 class="project-title">New Project</h3>
    <p class="project-description">Description here</p>
    <div class="project-tags">
        <span class="tag">Technology</span>
    </div>
    <div class="project-links">
        <a href="./projects/new-project/" class="project-link">View Details →</a>
    </div>
</div>
```

### Update Skills
Add skills in `index.html` Skills section:
```html
<div class="skill-item">New Skill</div>
```

## Content Recommendations

### Things to Add Later
- [ ] Professional headshot photo
- [ ] Project screenshots/demos
- [ ] Video demos (optional)
- [ ] Blog section (if desired)
- [ ] Testimonials/recommendations
- [ ] Certifications section

### Resume Tips
- Keep resume PDF up to date
- Match resume content to website
- Highlight key achievements
- Include keywords for ATS systems

## SEO & Analytics

### Improve Visibility
1. **Submit to Search Engines**
   - Google Search Console
   - Bing Webmaster Tools

2. **Add Analytics** (Optional)
   - Google Analytics
   - Plausible (privacy-friendly)

3. **Social Media Meta Tags**
   Add to `<head>`:
   ```html
   <meta property="og:title" content="Mario Urbina - B2B Integration Engineer">
   <meta property="og:description" content="Portfolio...">
   <meta property="og:image" content="./images/preview.png">
   ```

## Maintenance Schedule

### Weekly
- Check for broken links
- Review analytics (if enabled)
- Respond to contact inquiries

### Monthly
- Update project statuses
- Add new skills learned
- Review and update resume

### Quarterly
- Add new projects
- Update metrics and achievements
- Refresh testimonials

## Getting Help

### Resources
- [GitHub Pages Docs](https://docs.github.com/pages)
- [Netlify Docs](https://docs.netlify.com)
- [MDN Web Docs](https://developer.mozilla.org)

### Troubleshooting
See `DEPLOYMENT.md` for detailed troubleshooting steps.

### Contact
For technical questions about the portfolio:
- Create GitHub issue
- Review code comments
- Search Stack Overflow

## Best Practices

### Content
✅ Keep it concise and focused  
✅ Use active voice  
✅ Include measurable achievements  
✅ Show, don't just tell  
✅ Keep it updated  

### Design
✅ Mobile-first approach  
✅ Fast loading times  
✅ Accessible (WCAG compliant)  
✅ Consistent branding  
✅ Professional appearance  

### Technical
✅ Version control everything  
✅ Test on multiple browsers  
✅ Optimize images  
✅ Use HTTPS  
✅ Regular backups  

## Success Metrics

Track these to measure portfolio effectiveness:
- Page views
- Time on site
- Contact form submissions
- LinkedIn profile views
- Job inquiries received

## Congratulations! 🎉

Your professional portfolio is ready to launch. This is a powerful tool for your job search and career advancement.

Remember:
- Your portfolio represents you professionally
- Keep it current and accurate
- Quality over quantity
- Let your work speak for itself

Good luck with your job search!

---
*Created: February 2026*  
*Portfolio Framework by Mario Urbina*
