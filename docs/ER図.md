````mermaid
erDiagram
    USERS ||--o{ REQUESTED_ROUTES : "registers"
    REQUESTED_ROUTES ||--|{ REQUESTED_TIMES : "has"
    ADMIN_USERS {
        int id PK "NOT NULL"
        string email "NOT NULL"
        string password_digest "NOT NULL"
        integer role
        datetime created_at
        datetime updated_at
    }
    USERS {
        int id PK "NOT NULL"
        string user_name "NOT NULL"
        string password_digest "NOT NULL"
        string postcode
        int num_of_children "NOT NULL"
        datetime created_at
        datetime updated_at
    }
    REQUESTED_ROUTES {
        int id PK "NOT NULL"
        int user_id FK "NOT NULL"
        string start_point_name "出発地名"
        geometry start_point_location "NOT NULL, 出発地点"
        string end_point_name "目的地名"
        geometry end_point_location "NOT NULL, 目的地点"
        string purpose "通学,部活,習い事など"
        string comment "改善希望など"
        boolean is_existing_service_available "NOT NULL 既存ダイヤ利用可否"
        datetime created_at
        datetime updated_at
    }
    REQUESTED_TIMES {
       int id PK "NOT NULL"
       int requested_route_id FK "NOT NULL"
       string requested_day "NOT NULL 曜日"
       time requested_time "NOT NULL 希望時間帯"
       string departure_or_arrival "NOT NULL"
       datetime created_at
       datetime updated_at
    }
````