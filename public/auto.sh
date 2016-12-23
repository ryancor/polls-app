git status
read -r -p 'Please enter your commit message >>> ' var
git add .
git commit -m "$var"
git push origin master