# Endpoints

## USER

### POST /register

Registers a new user and returns a JWT token.

```JSON
{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123"
}
```

### POST /login

Logs in a user and returns a JWT token.

- Request Body
  ```JSON
  {
      "email": "john@example.com",
      "password": "password123"
  }
  ```

### GET /profile

Logs in a user and returns a JWT token

- Header
  - Authorization: `Bearer < token >`

## Budget

- Belongs to User
- Has many Budget Items

### GET /budgets

Returns list of Budgets create by the User

- Header
  - Authorization: `Bearer < token >`

Sample Response:

```JSON
{
    "id": 5,
    "user_id": 1,
    "start_date": "2024-04-01",
    "end_date": "2024-05-31",
    "created_at": "2024-09-07T15:24:55.190Z",
    "updated_at": "2024-09-07T15:24:55.190Z"
}
```

### POST /budgets

Create a new Budget for the User

- Request Body
  ```JSON
  {
    "budget": {
        "start_date": "2024-06-01",
        "end_date": "2024-06-30"
    }
  }
  ```
- Sample Response
  ```JSON
  {
      "id": 6,
      "user_id": 1,
      "start_date": "2024-06-01",
      "end_date": "2024-06-30",
      "created_at": "2024-09-07T15:27:57.127Z",
      "updated_at": "2024-09-07T15:27:57.127Z"
  }
  ```

### GET /budgets/:id

Get the Budget with `:id` created by the User if it exists. This will include nested `budget_items` linked to this Budget.

- Sample Response
  - `budget_id = 6`, `user_id = 1` -> `budget_items = []`
  ```JSON
  {
      "id": 6,
      "user_id": 1,
      "start_date": "2024-06-01",
      "end_date": "2024-06-30",
      "created_at": "2024-09-07T15:27:57.127Z",
      "updated_at": "2024-09-07T15:27:57.127Z",
      "budget_items": []
  }
  ```
  - `budget_id = 3`, `user_id = 1` -> `budget_items = [non-empty]`
  ```JSON
    {
        "id": 3,
        "user_id": 1,
        "start_date": "2024-03-01",
        "end_date": "2024-12-31",
        "created_at": "2024-09-06T02:12:26.180Z",
        "updated_at": "2024-09-06T02:12:26.180Z",
        "budget_items": [
            {
                "id": 2,
                "budget_id": 3,
                "name": "Groceries",
                "amount": "200.0",
                "category": "Food",
                "item_type": "Expense",
                "created_at": "2024-09-06T02:14:12.985Z",
                "updated_at": "2024-09-06T02:14:12.985Z"
            },
            {
                "id": 3,
                "budget_id": 3,
                "name": "FOOOD",
                "amount": "200.0",
                "category": "Food",
                "item_type": "Expense",
                "created_at": "2024-09-06T02:14:18.503Z",
                "updated_at": "2024-09-06T02:14:18.503Z"
            },
            {
                "id": 4,
                "budget_id": 3,
                "name": "FOOOD",
                "amount": "200.0",
                "category": "Food",
                "item_type": "Expense",
                "created_at": "2024-09-06T02:15:12.019Z",
                "updated_at": "2024-09-06T02:15:12.019Z"
            }
        ]
    }
  ```

### PUT /budgets/:id

- Request Body

  ```JSON
  {
      "budget": {
          "start_date": "2024-12-02" //only changing the start date
      }
  }
  ```

- Response
  ```JSON
  {
      "user_id": 1,
      "start_date": "2024-12-02",
      "id": 6,
      "end_date": "2024-06-30",
      "created_at": "2024-09-07T15:27:57.127Z",
      "updated_at": "2024-09-07T15:31:54.914Z"
  }
  ```

### DELETE /budgets/:id

- Success Response - `{}`
- Errors
  ```JSON
  {
      "error": "Budget not found"
  }
  ```

## Budget Items

- Belongs to Budget

### POST /budgets/:budget_id/budget_items

- Request Body
  ```JSON
    {
        "budget_item": {
          "name": "FOOOD",
          "amount": 200.00,
          "category": "Food",
          "item_type": "Expense"
        }
    }
  ```
- Response Body
  ```JSON
  {
      "id": 6,
      "budget_id": 3,
      "name": "FOOOD",
      "amount": "200.0",
      "category": "Food",
      "item_type": "Expense",
      "created_at": "2024-09-07T15:35:38.378Z",
      "updated_at": "2024-09-07T15:35:38.378Z"
  }
  ```

### PUT /budgets/:budget_id/budget_items/:budget_item_id

- Request Body

  ```JSON
  {
      "budget_item": {
        "name": "Groceries"
      }
  }
  ```

- Response Body
  ```JSON
  {
      "budget_id": 3,
      "name": "Groceries",
      "amount": "200.0",
      "id": 6,
      "category": "Food",
      "item_type": "Expense",
      "created_at": "2024-09-07T15:35:38.378Z",
      "updated_at": "2024-09-07T15:38:20.154Z"
  }
  ```

### DELETE /budgets/:budget_id/budget_items/:budget_item_id

- Success Response
  ```JSON
  {
      "message": "Budget item deleted"
  }
  ```

## Refresh Token

### POST /refresh

- Request Body
  ```JSON
  {
    "refresh_token": "...."
  }
  ```
- Success Response
  ```JSON
  {
    "token": "...."
  }
  ```
- Unauthorized (eg. expired refresh_token)
  ```JSON
  {
    "errors": "Refresh token has been expired"
  }
  ```
