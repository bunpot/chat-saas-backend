FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    libpq-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    unzip \
    git \
    curl \
    supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd zip opcache
    # ตั้งค่า Working Directory
WORKDIR /var/www/html

# คัดลอกโค้ดทั้งหมดเข้าคอนเทนเนอร์
COPY . /var/www/html

# ตั้งค่าสิทธิ์โฟลเดอร์ storage และ bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# คัดลอกไฟล์คอนฟิก Nginx (ถ้ามี) หรือปรับพอร์ต default ของ Nginx ให้รับพอร์ตจาก Render ($PORT)
RUN sed -i 's/listen 80;/listen ${PORT:-10000};/g' /etc/nginx/sites-available/default

# คำสั่งสำหรับรัน Nginx และ PHP-FPM พร้อมกันตอน Start คอนเทนเนอร์
CMD service nginx start && php-fpm