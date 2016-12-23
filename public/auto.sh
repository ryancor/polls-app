git status
read -r -p 'Please enter your commit message >>> ' var
if [ $var == 'Exit' ]; then
	exit 1
else
	git add .
	git commit -m "$var"
	git push origin master
fi