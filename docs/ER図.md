````mermaid
erDiagram
    USERS ||--|| USER_PROFILES : "has one"
    USERS ||--o{ CHILDREN : "has"
    CHILDREN ||--o{ REQUESTED_ROUTES : "registers"
    CHILDREN ||--o{ ANSWERS : "has"
    REQUESTED_ROUTES ||--o{ REQUESTED_TIMES : "has"
    ADMIN_USERS ||--o{ SURVEYS : "has"
    SURVEYS ||--o{ QUESTIONS : "has"
    SURVEYS ||--o{ REQUESTED_ROUTES : "has"
    QUESTIONS ||--o{ QUESTION_OPTIONS : "has"
    QUESTIONS ||--o{ ANSWERS : "is answered in"
    ANSWERS ||--o{ ANSWER_OPTIONS : "has selected"
    QUESTION_OPTIONS ||--o{ ANSWER_OPTIONS : "is selected in"

    ADMIN_USERS {
        int id PK
        string user_name "NOT NULL"
        string password_digest "NOT NULL"
        string role "NOT NULL, enum"
        datetime created_at
        datetime updated_at
    }

    USERS {
        int id PK "NOT NULL"
        string user_name "NOT NULL"
        string password_digest "NOT NULL"
        datetime created_at
        datetime updated_at
    }

    USER_PROFILES {
        int id PK
        int user_id FK "NOT NULL, UNIQUE"
        string postcode
        int num_of_objects "NOT NULL 調査対象者の数"
        datetime created_at
        datetime updated_at
    }

    CHILDREN {
        int id PK "NOT NULL"
        int user_id FK "NOT NULL"
        string postcode
        string school_name
        int grade "NOT NULL"
        int school_type "NOT NULL, enum, elementary, secondary, high"
        datetime created_at
        datetime updated_at
    }

    REQUESTED_ROUTES {
        int id PK "NOT NULL"
        int subject_id FK "NOT NULL"
        int survey_id FK "NOT NULL"
        string subject_type "NOT NULL, 'Child'など"
        string start_point_name "出発地名"
        geometry start_point_location "NOT NULL, 出発地点"
        string end_point_name "目的地名"
        geometry end_point_location "NOT NULL, 目的地点"
        string purpose "通学,部活,習い事など"
        text route_comment
        boolean is_existing_service_available "NOT NULL"
        datetime created_at
        datetime updated_at
    }

    REQUESTED_TIMES {
       int id PK "NOT NULL"
       int requested_route_id FK "NOT NULL"
       string requested_day "NOT NULL 曜日"
       time requested_time "NOT NULL 希望時間帯"
       string departure_or_arrival "NOT NULL, 出発 or 到着"
       datetime created_at
       datetime updated_at
    }

    SURVEYS {
        int id PK "NOT NULL"
        int admin_user_id FK "NOT NULL"
        string survey_name "NOT NULL"
    }

    QUESTIONS {
        int id PK "NOT NULL"
        int survey_id FK "NOT NULL"
        text text "NOT NULL, 質問文"
        int question_type "NOT NULL, multiple_choice free_text, multiple_choice_and_free_text"
        int display_order "表示順"
        datetime created_at
        datetime updated_at
    }

    QUESTION_OPTIONS {
        int id PK "NOT NULL"
        int question_id FK "NOT NULL"
        string text "NOT NULL, 選択肢の文言"
        int display_order "NOT NULL, 表示順"
        datetime created_at
        datetime updated_at
    }

    ANSWERS {
        int id PK "NOT NULL"
        int subject_id FK "NOT NULL"
        string subject_type "NOT NULL, 'Child'など"
        int question_id FK "NOT NULL"
        text free_text "自由回答"
        datetime created_at
        datetime updated_at
    }

    ANSWER_OPTIONS {
        int id PK "NOT NULL"
        int answer_id FK "NOT NULL"
        int question_option_id FK "NOT NULL"
        datetime created_at
        datetime updated_at
    }
````