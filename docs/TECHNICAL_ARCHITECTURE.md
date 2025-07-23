# Technical Architecture

## System Components

### 1. Frontend (Flutter)
- **Responsive Design**
  - Support for tablet resolution
  - Portrait/Landscape modes
  - Adaptive UI for different roles

- **User Interfaces**
  1. Guard Interface
  2. Student Interface
  3. Warden Interface
  4. Faculty Interface

### 2. Backend Services
- **Authentication Service**
  - Role-based access control
  - QR code validation
  - Permission management

- **Notification Service**
  - Real-time notifications
  - Push notifications
  - Status updates

- **Data Management**
  - Entry/Exit logs
  - Permission requests
  - Visitor management
  - CSV export functionality

### 3. Hardware Integration
- **Camera System**
  - 2K resolution support
  - Photo capture capability
  - QR code scanning

- **Display System**
  - Multiple setup support
  - Touch interface
  - Optional keyboard integration

### 4. Database Schema

```
Users:
- id (PK)
- role (enum: student, faculty, warden, guard)
- name
- email
- phone
- created_at
- updated_at

Entries:
- id (PK)
- user_id (FK)
- entry_time
- exit_time
- entry_type (normal, after_hours, visitor)
- status
- approved_by
- created_at

Permissions:
- id (PK)
- student_id (FK)
- warden_id (FK)
- request_time
- status
- reason
- valid_until
- created_at

Visitors:
- id (PK)
- name
- phone
- purpose
- host_id (FK)
- entry_time
- exit_time
- status
- created_at

FestQR:
- id (PK)
- event_name
- valid_from
- valid_until
- created_by
- status
- created_at
```

### 5. API Endpoints

```
/auth
  POST /login
  POST /logout
  GET  /profile

/entries
  POST /scan
  POST /manual-entry
  GET  /history
  GET  /export-csv

/permissions
  POST /request
  PUT  /approve
  PUT  /deny
  GET  /pending

/notifications
  GET  /unread
  PUT  /mark-read
  POST /send

/visitors
  POST /register
  PUT  /approve
  PUT  /deny
  GET  /active
```

### 6. Security Measures
- End-to-end encryption for sensitive data
- Role-based access control
- Session management
- Rate limiting
- Audit logging

### 7. Monitoring
- System health metrics
- Usage statistics
- Error logging
- Performance monitoring

### 8. Backup & Recovery
- Daily database backups
- System state backups
- Recovery procedures
- Data retention policies
