### Создание проекта в рамках курса на stepic.org

# $ mkdir -p /home/box/web
# $ git clone https://github.com/pilosus/stepic_web_project.git /home/box/web
# $ bash /home/box/web/init.sh
# if git files changed locally, stash or reset:
# $ git reset --hard

# create symbolic link to a new nginx config
sudo ln -sf /home/box/web/etc/nginx.conf  /etc/nginx/sites-enabled/django.conf
sudo rm /etc/nginx/sites-enabled/default.conf

# restart nginx
sudo /etc/init.d/nginx restart

# in /etc/nginx/sites-enabled/default
# first two comment lines with listen 80 /server_default

# create DB
mysql -uroot -e "create database django"

# creare symbolic links to gunicorn configs
sudo ln -sf /home/box/web/etc/hello.py  /etc/gunicorn.d/hello.py
sudo ln -sf /home/box/web/etc/django-gunicorn.conf  /etc/gunicorn.d/django-gunicorn.conf

# run gunicorn server
cd /home/box/web/ask
sudo gunicorn -с /etc/gunicorn.d/hello.py hello:app
sudo gunicorn -с /etc/gunicorn.d/django-gunicorn.conf ask.wsgi:application
