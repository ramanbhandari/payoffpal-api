## Endpoints

### POST /register
Registers a new user and returns a JWT token.
```bash
{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123"
}
```

### POST /login
Logs in a user and returns a JWT token.
- Request Body
    ```bash
    {
        "email": "john@example.com",
        "password": "password123"
    }
    ```

### GET /profile
Logs in a user and returns a JWT token
- Header
    - Authorization: Bearer < token >

### GET /budgets

### GET /budgets/:id

### POST /budgets

### PUT /budgets/:id

### GET /budgets/:id/budget_item



