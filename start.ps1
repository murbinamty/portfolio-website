# Portfolio Website Quick Start
# PowerShell script to help you get started

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Mario Urbina - Portfolio Setup" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Check if resume exists
$resumePath = "c:\AI_EDI\Mario_Urbina_26A.pdf"
$portfolioPath = "c:\AI_EDI\portfolio-website"

if (Test-Path $resumePath) {
    Write-Host "✓ Resume found!" -ForegroundColor Green
    Write-Host "  Copying to portfolio folder..." -ForegroundColor Yellow
    Copy-Item $resumePath "$portfolioPath\Mario_Urbina_26A.pdf" -Force
    Write-Host "  Done!" -ForegroundColor Green
} else {
    Write-Host "⚠ Resume not found at: $resumePath" -ForegroundColor Yellow
    Write-Host "  Please copy your resume manually to the portfolio folder" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📂 Portfolio Location:" -ForegroundColor Cyan
Write-Host "  $portfolioPath" -ForegroundColor White
Write-Host ""

# Open portfolio in browser
Write-Host "🌐 Opening portfolio in browser..." -ForegroundColor Cyan
Start-Process "$portfolioPath\index.html"

Write-Host ""
Write-Host "📋 Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Review the website in your browser" -ForegroundColor White
Write-Host "  2. Read SETUP.md for customization options" -ForegroundColor White
Write-Host "  3. Read DEPLOYMENT.md for deployment instructions" -ForegroundColor White
Write-Host "  4. Initialize Git and push to GitHub" -ForegroundColor White
Write-Host ""

Write-Host "🚀 Git Setup Commands:" -ForegroundColor Cyan
Write-Host "  cd $portfolioPath" -ForegroundColor Yellow
Write-Host "  git init" -ForegroundColor Yellow
Write-Host "  git add ." -ForegroundColor Yellow
Write-Host '  git commit -m "Initial commit: Professional portfolio"' -ForegroundColor Yellow
Write-Host "  git remote add origin https://github.com/YOUR_USERNAME/portfolio.git" -ForegroundColor Yellow
Write-Host "  git branch -M main" -ForegroundColor Yellow
Write-Host "  git push -u origin main" -ForegroundColor Yellow
Write-Host ""

Write-Host "✅ Setup complete! Your portfolio is ready to deploy!" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
