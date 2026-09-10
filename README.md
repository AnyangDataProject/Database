# 🗄️ Database Schema

## ERD

```text
users
 ├── 1:N ── reports
 │              ├── 1:N ── report_images
 │              └── 1:N ── ai_analyses
 │                             └── 1:N ── ai_detections
 │
 └── 1:N ── inquiries
                └── 1:N ── inquiry_files
```

---

## 1. users

시민 및 관리자 계정 정보를 저장하는 테이블입니다.

| 컬럼명 | 타입 | NULL | 기본값 | 설명 |
|---|---|:---:|---|---|
| `id` | BIGINT | N | AUTO_INCREMENT | 사용자 고유 ID |
| `email` | VARCHAR(255) | N | - | 로그인 이메일 |
| `password` | VARCHAR(255) | N | - | 암호화된 비밀번호 |
| `name` | VARCHAR(100) | N | - | 사용자 이름 |
| `phone` | VARCHAR(30) | Y | NULL | 사용자 전화번호 |
| `role` | ENUM | N | `CITIZEN` | 사용자 권한 |
| `created_at` | DATETIME | N | CURRENT_TIMESTAMP | 계정 생성일 |

### Role

| 값 | 설명 |
|---|---|
| `CITIZEN` | 일반 시민 |
| `ADMIN` | 관리자 |

> 회원가입 시 기본 권한은 `CITIZEN`으로 설정합니다.  
> 관리자 계정은 별도로 `ADMIN` 권한을 부여합니다. => 백엔드에서 특정한 계정으로 로그인 시 admin 권한 부여 예정

---

## 2. reports

시민이 등록한 도로 파손 신고 정보를 저장하는 테이블입니다.

| 컬럼명 | 타입 | NULL | 기본값 | 설명 |
|---|---|:---:|---|---|
| `id` | BIGINT | N | AUTO_INCREMENT | 신고 고유 ID |
| `user_id` | BIGINT | N | - | 신고자 ID (`users.id`) |
| `description` | TEXT | N | - | 도로 파손 상세 내용 |
| `severity` | ENUM | Y | NULL | 도로 파손 심각도 |
| `status` | ENUM | N | `RECEIVED` | 신고 처리 상태 |
| `latitude` | DECIMAL(10,7) | N | - | 신고 위치 위도 |
| `longitude` | DECIMAL(10,7) | N | - | 신고 위치 경도 |
| `address` | VARCHAR(500) | Y | NULL | 신고 위치 주소 |
| `created_at` | DATETIME | N | CURRENT_TIMESTAMP | 신고 최초 등록일 |
| `updated_at` | DATETIME | N | CURRENT_TIMESTAMP | 신고 정보 및 상태 최종 수정일 |

### Severity

| 값 | 설명 |
|---|---|
| `LOW` | 경미 |
| `MEDIUM` | 보통 |
| `HIGH` | 심각 |

### Status

| 값 | 설명 |
|---|---|
| `RECEIVED` | 신고 접수 |
| `IN_PROGRESS` | 처리 중 |
| `COMPLETED` | 처리 완료 |

> `created_at`은 신고가 최초 등록된 시점입니다.  
> `updated_at`은 신고 정보 또는 처리 상태가 마지막으로 변경된 시점입니다.

---

## 3. report_images

도로 파손 신고에 첨부된 이미지를 저장하는 테이블입니다. => 여러개의 사진 첨부할 수 있기 때문에 별도로 분리함

| 컬럼명 | 타입 | NULL | 기본값 | 설명 |
|---|---|:---:|---|---|
| `id` | BIGINT | N | AUTO_INCREMENT | 이미지 고유 ID |
| `report_id` | BIGINT | N | - | 신고 ID (`reports.id`) |
| `image_url` | VARCHAR(500) | N | - | S3 이미지 URL |
| `image_key` | VARCHAR(500) | N | - | S3 객체 Key |
| `created_at` | DATETIME | N | CURRENT_TIMESTAMP | 이미지 등록일 |

> 실제 이미지 파일은 AWS S3에 저장하며,  
> DB에는 이미지 URL과 S3 Key를 저장합니다.

---

## 4. ai_analyses

도로 파손 이미지에 대한 AI 분석 정보를 저장하는 테이블입니다. => S3에 사용자가 올린 이미지 + 결과 이미지 함께 저장 예정

| 컬럼명 | 타입 | NULL | 기본값 | 설명 |
|---|---|:---:|---|---|
| `id` | BIGINT | N | AUTO_INCREMENT | AI 분석 고유 ID |
| `report_id` | BIGINT | N | - | 신고 ID (`reports.id`) |
| `model_name` | VARCHAR(100) | N | - | 사용된 AI 모델명 |
| `model_version` | VARCHAR(50) | N | - | 사용된 AI 모델 버전 |
| `analyzed_at` | DATETIME | N | CURRENT_TIMESTAMP | AI 분석 완료 시간 |
| `processing_time` | BIGINT | Y | NULL | AI 분석 소요 시간 (ms) |
| `result_image_url` | VARCHAR(500) | Y | NULL | AI 분석 결과 이미지 URL |
| `result_image_key` | VARCHAR(500) | Y | NULL | AI 분석 결과 이미지 S3 Key |

### Model Information

AI 모델이 변경되거나 개선될 경우 분석에 사용된 모델을 추적할 수 있도록 모델명과 버전을 저장합니다.

```text
model_name    = YOLOv8
model_version = 1.0
```

---

## 5. ai_detections

AI 분석 과정에서 탐지된 각각의 도로 파손 객체 정보를 저장하는 테이블입니다.

| 컬럼명 | 타입 | NULL | 기본값 | 설명 |
|---|---|:---:|---|---|
| `id` | BIGINT | N | AUTO_INCREMENT | 탐지 결과 고유 ID |
| `ai_analysis_id` | BIGINT | N | - | AI 분석 ID (`ai_analyses.id`) |
| `class_name` | VARCHAR(100) | N | - | 탐지된 객체 클래스명 |
| `confidence` | DECIMAL(5,4) | N | - | AI 탐지 신뢰도 점수 |
| `bbox_x` | INT | N | - | Bounding Box X 좌표 |
| `bbox_y` | INT | N | - | Bounding Box Y 좌표 |
| `bbox_width` | INT | N | - | Bounding Box 너비 |
| `bbox_height` | INT | N | - | Bounding Box 높이 |

### Detection Information

| 컬럼 | 설명 |
|---|---|
| `class_name` | AI가 탐지한 도로 파손 종류 |
| `confidence` | 해당 객체라고 판단한 AI의 신뢰도 점수 |
| `bbox_x` | 탐지 영역의 X 시작 좌표 |
| `bbox_y` | 탐지 영역의 Y 시작 좌표 |
| `bbox_width` | 탐지 영역의 가로 크기 |
| `bbox_height` | 탐지 영역의 세로 크기 |

> Bounding Box 정보는 AI가 탐지한 파손 위치를 이미지 위에 표시하기 위해 사용합니다.

---

## 6. inquiries

시민이 등록한 민원 및 문의 정보를 저장하는 테이블입니다.

| 컬럼명 | 타입 | NULL | 기본값 | 설명 |
|---|---|:---:|---|---|
| `id` | BIGINT | N | AUTO_INCREMENT | 문의 고유 ID |
| `user_id` | BIGINT | N | - | 문의 작성자 ID (`users.id`) |
| `inquiry_type` | ENUM | N | - | 문의 유형 |
| `title` | VARCHAR(200) | N | - | 문의 제목 |
| `content` | TEXT | N | - | 문의 내용 |
| `email` | VARCHAR(255) | N | - | 답변 받을 이메일 |
| `privacy_agreed` | BOOLEAN | N | FALSE | 개인정보 수집 및 이용 동의 여부 |
| `privacy_agreed_at` | DATETIME | Y | NULL | 개인정보 동의 시간 |
| `status` | ENUM | N | `WAITING` | 문의 처리 상태 |
| `answer` | TEXT | Y | NULL | 관리자 답변 |
| `answered_by` | BIGINT | Y | NULL | 답변 관리자 ID (`users.id`) |
| `answered_at` | DATETIME | Y | NULL | 답변 등록 시간 |
| `created_at` | DATETIME | N | CURRENT_TIMESTAMP | 문의 등록일 |
| `updated_at` | DATETIME | N | CURRENT_TIMESTAMP | 문의 정보 최종 수정일 |

### Inquiry Type

| 값 | 설명 |
|---|---|
| `REPORT` | 신고 관련 문의 |
| `RESULT` | 처리 결과 문의 |
| `SERVICE` | 서비스 이용 문의 |
| `ETC` | 기타 민원 |

### Inquiry Status

| 값 | 설명 |
|---|---|
| `WAITING` | 답변 대기 |
| `ANSWERED` | 답변 완료 |

---

## 7. inquiry_files

민원 및 문의에 첨부된 파일 정보를 저장하는 테이블입니다.

| 컬럼명 | 타입 | NULL | 기본값 | 설명 |
|---|---|:---:|---|---|
| `id` | BIGINT | N | AUTO_INCREMENT | 첨부파일 고유 ID |
| `inquiry_id` | BIGINT | N | - | 문의 ID (`inquiries.id`) |
| `file_name` | VARCHAR(255) | N | - | 원본 파일명 |
| `file_url` | VARCHAR(500) | N | - | S3 파일 URL |
| `created_at` | DATETIME | N | CURRENT_TIMESTAMP | 파일 등록일 |

> 문의 첨부파일은 AWS S3에 저장하고 DB에는 파일 URL을 저장합니다.

---

# 🔗 Table Relationships

| 관계 | 설명 |
|---|---|
| `users` 1 : N `reports` | 한 사용자는 여러 건의 도로 파손 신고를 등록할 수 있습니다. |
| `reports` 1 : N `report_images` | 하나의 신고에는 여러 장의 이미지를 첨부할 수 있습니다. |
| `reports` 1 : N `ai_analyses` | 하나의 신고에 대해 AI 분석이 수행될 수 있습니다. |
| `ai_analyses` 1 : N `ai_detections` | 하나의 AI 분석에서 여러 개의 파손 객체가 탐지될 수 있습니다. |
| `users` 1 : N `inquiries` | 한 사용자는 여러 건의 민원 및 문의를 등록할 수 있습니다. |
| `inquiries` 1 : N `inquiry_files` | 하나의 문의에는 여러 개의 첨부파일을 등록할 수 있습니다. |
| `users` 1 : N `inquiries` (`answered_by`) | 관리자는 여러 문의에 답변할 수 있습니다. |

---
ㅓ

### Storage Policy

실제 파일은 AWS S3에 저장하고, MySQL에는 파일 자체가 아닌 파일에 대한 정보를 저장합니다.

```text
AWS S3
└── 실제 이미지 / 첨부파일

MySQL
├── image_url
├── image_key
└── file_url
```

### SQL 생성문 쿼리

Dump 파일 임포트 안하고 아래의 SQL 문 복사해서 쓰셔도 됩니다.

```text
CREATE DATABASE IF NOT EXISTS anyangproj DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;
USE anyangproj;


-- =========================================================
-- 1. users
-- 시민 / 관리자 계정
-- =========================================================
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(30),

    role ENUM('CITIZEN', 'ADMIN') NOT NULL DEFAULT 'CITIZEN',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- =========================================================
-- 2. reports
-- 시민 도로 위험 신고
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
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_reports_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);


-- =========================================================
-- 3. report_images
-- 신고에 첨부된 이미지
-- 실제 이미지는 S3에 저장하고 URL만 DB에 저장
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
-- 4. ai_analyses
-- YOLO AI 분석 결과
-- =========================================================
CREATE TABLE ai_analyses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    report_id BIGINT NOT NULL,

    model_name VARCHAR(100) NOT NULL,
    model_version VARCHAR(50),

    result_image_url VARCHAR(1000),

    analyzed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ai_analyses_report
        FOREIGN KEY (report_id)
        REFERENCES reports(id)
        ON DELETE CASCADE
);


-- =========================================================
-- 5. ai_detections
-- YOLO가 실제로 탐지한 객체들
-- 한 번의 AI 분석에서 여러 개의 객체가 나올 수 있음
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
-- 6. inquiries
-- 시민 문의
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
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_inquiries_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_inquiries_admin
        FOREIGN KEY (answered_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

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
show tables;

select * from users;
select * from reports;
select * from report_images;
select * from inquiries;
select * from ai_detections;
select * from ai_analyses;
select * from inquiry_files;
```
