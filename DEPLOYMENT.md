# Deployment Guide

## Deploy to GitHub Pages

### Prerequisites
- GitHub account
- Git installed locally
- Repository created on GitHub

### Step 1: Initialize Git Repository
```bash
cd c:\AI_EDI\portfolio-website

# Initialize repository
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Portfolio website"
```

### Step 2: Create GitHub Repository
```bash
# Create repository on GitHub (replace with your username)
# Repository name: portfolio

# Add remote
git remote add origin https://github.com/YOUR_USERNAME/portfolio.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### Step 3: Enable GitHub Pages
1. Go to repository Settings
2. Navigate to Pages section (left sidebar)
3. Under "Source", select `main` branch
4. Select `/root` as the folder
5. Click **Save**
6. Your site will be live at: `https://YOUR_USERNAME.github.io/portfolio/`

### Step 4: Add Custom Domain (Optional)
1. Purchase a domain (e.g., mariou rbina.dev)
2. In repository Settings → Pages
3. Enter your custom domain
4. Update DNS settings:
   ```
   Type: A
   Name: @
   Value: 185.199.108.153
          185.199.109.153
          185.199.110.153
          185.199.111.153
   
   Type: CNAME
   Name: www
   Value: YOUR_USERNAME.github.io
   ```

## Deploy to Netlify (Alternative)

### Prerequisites
- Netlify account (free)

### Quick Deploy
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
cd c:\AI_EDI\portfolio-website
netlify deploy --prod
```

### Continuous Deployment
1. Push code to GitHub
2. Login to Netlify (https://netlify.com)
3. Click "New site from Git"
4. Connect to your GitHub repository
5. Configure:
   - Build command: (leave empty)
   - Publish directory: `.`
6. Click "Deploy site"

Your site will be live at: `https://random-name-123.netlify.app`

### Custom Domain on Netlify
1. Go to Site settings → Domain management
2. Click "Add custom domain"
3. Enter your domain
4. Update DNS records as instructed

## Update Resume

### Add Your Resume PDF
1. Copy your resume PDF to the portfolio-website folder
2. Rename to `Mario_Urbina_26A.pdf` (or update references in HTML)
3. Commit and push:
   ```bash
   git add Mario_Urbina_26A.pdf
   git commit -m "Add resume PDF"
   git push
   ```

## Continuous Updates

### Adding New Projects
1. Create new folder in `projects/`
2. Add README.md with project details
3. Update `index.html` to add project card
4. Commit and push

### Updating Skills
1. Edit `index.html` in the Skills section
2. Add new skill items
3. Commit and push

### Analytics (Optional)

#### Google Analytics
Add to `<head>` in index.html:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

## Maintenance

### Regular Updates
- Update projects quarterly
- Refresh resume every 6 months
- Add new skills as acquired
- Update contact information as needed

### Performance Optimization
```bash
# Minify CSS and JS (optional)
npm install -g clean-css-cli uglify-js

# Minify CSS
cleancss -o css/style.min.css css/style.css

# Minify JS
uglifyjs js/main.js -o js/main.min.js -c -m

# Update HTML to use minified versions
```

### Backup Strategy
- Keep source code in GitHub
- Export resume backup monthly
- Save project documentation locally
- Version control everything

## Troubleshooting

### Site Not Loading
1. Check GitHub Pages is enabled
2. Verify branch and folder settings
3. Check for build errors in Actions tab
4. Clear browser cache

### Broken Links
1. Use relative paths for all local files
2. Test locally before pushing
3. Use browser dev tools to check console errors

### Mobile Display Issues
1. Test on multiple devices
2. Use Chrome DevTools device emulation
3. Adjust CSS media queries if needed

## SEO Optimization

### Meta Tags
Already included in index.html:
- Title tag
- Description meta tag
- Keywords meta tag
- Author meta tag

### Additional SEO
1. Submit sitemap to Google Search Console
2. Add robots.txt
3. Optimize images (compress, use alt tags)
4. Add structured data (JSON-LD)

## Support
For issues or questions:
- Check GitHub Issues
- Review GitHub Pages documentation
- Contact: mario.urbina@gmail.com
