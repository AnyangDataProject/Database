# 🗄️ Database Schema 9월 12일 수정본


### SQL 생성문 쿼리

Dump 파일 임포트 안하고 아래의 SQL 문 복사해서 쓰셔도 됩니다.

```text
DROP DATABASE IF EXISTS anyangproj;
CREATE DATABASE IF NOT EXISTS anyangproj DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;
USE anyangproj;

-- =========================================================
-- 1. users (시민 / 관리자 계정)
-- =========================================================
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(30),

    role ENUM('CITIZEN', 'ADMIN') NOT NULL DEFAULT 'CITIZEN',
    provider VARCHAR(255),
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    last_login DATETIME,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 2. reports (시민 도로 위험 신고)
-- =========================================================
CREATE TABLE reports (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    description TEXT,
    latitude DECIMAL(10, 7) NOT NULL,
    longitude DECIMAL(10, 7) NOT NULL,
    address VARCHAR(500),

    damage_type VARCHAR(50),
    severity ENUM('LOW', 'MEDIUM', 'HIGH'),

    status ENUM(
        'RECEIVED',
        'AI_ANALYZED',
        'CONFIRMED',
        'IN_PROGRESS',
        'COMPLETED',
        'REJECTED'
    ) NOT NULL DEFAULT 'RECEIVED',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_reports_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

-- =========================================================
-- 3. report_images (신고 첨부 이미지)
-- =========================================================
CREATE TABLE report_images (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    report_id BIGINT NOT NULL,

    image_url VARCHAR(1000) NOT NULL,
    image_type VARCHAR(50),

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_report_images_report
        FOREIGN KEY (report_id)
        REFERENCES reports(id)
        ON DELETE CASCADE
);

-- =========================================================
-- 4. ai_analyses (YOLO AI 분석 결과)
-- =========================================================
CREATE TABLE ai_analyses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    report_id BIGINT NOT NULL,
    report_image_id BIGINT,

    model_name VARCHAR(100) NOT NULL,
    model_version VARCHAR(50),

    result_image_url VARCHAR(1000),

    analyzed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ai_analyses_report
        FOREIGN KEY (report_id)
        REFERENCES reports(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ai_analysis_report_image
        FOREIGN KEY (report_image_id)
        REFERENCES report_images(id)
        ON DELETE SET NULL
);

-- =========================================================
-- 5. ai_detections (YOLO 객체 탐지 상세)
-- =========================================================
CREATE TABLE ai_detections (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    ai_analysis_id BIGINT NOT NULL,

    class_name VARCHAR(100) NOT NULL,
    confidence DECIMAL(5, 4) NOT NULL,

    bbox_x DECIMAL(10, 4),
    bbox_y DECIMAL(10, 4),
    bbox_width DECIMAL(10, 4),
    bbox_height DECIMAL(10, 4),

    CONSTRAINT fk_ai_detections_analysis
        FOREIGN KEY (ai_analysis_id)
        REFERENCES ai_analyses(id)
        ON DELETE CASCADE
);

-- =========================================================
-- 6. inquiries (시민 문의)
-- =========================================================
CREATE TABLE inquiries (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT NOT NULL,

    inquiry_type ENUM(
        'REPORT',
        'RESULT',
        'SERVICE',
        'ETC'
    ) NOT NULL,

    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,

    email VARCHAR(255) NOT NULL,

    status ENUM(
        'WAITING',
        'ANSWERED'
    ) NOT NULL DEFAULT 'WAITING',

    answer TEXT,
    answered_by BIGINT,
    answered_at DATETIME,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_inquiries_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_inquiries_admin
        FOREIGN KEY (answered_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- =========================================================
-- 7. inquiry_files (문의 첨부 파일)
-- =========================================================
CREATE TABLE inquiry_files (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    inquiry_id BIGINT NOT NULL,

    file_name VARCHAR(255) NOT NULL,
    file_url VARCHAR(500) NOT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_inquiry_files_inquiry
        FOREIGN KEY (inquiry_id)
        REFERENCES inquiries(id)
        ON DELETE CASCADE
);
```
