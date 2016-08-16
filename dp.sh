hexo g
hexo d
git checkout source
git add .
if [ $# -lt 1 ]; then
git commit -a --allow-empty-message -m ""
else
git commit -m "$1"
fi
git push origin source


