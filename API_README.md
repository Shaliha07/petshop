## RESTful API Endpoints

#### Base URL

`http://localhost:8000/`

### Endpoints

#### 1. **User Registration**

- **URL:** `auth/register`
- **Method:** `POST`
- **Request Body:** `**`

```json
{
  "username": "johndoe",
  "email": "johndoe@example.com",
  "password": "securePassword123",
  "firstName": "John",
  "lastName": "Doe",
  "role": "user"
}
```

#### 2. **User Login**

- **URL:** `auth/login`
- **Method:**: `POST`
- **Request Body:**

```json
{
  "username": "johndoe",
  "password": "securePassword123"
}
```

#### 3. **User Logout**

- **URL:** `auth/logout`
- **Method:** `POST`

#### 4. **Retrieve Users**

- **URL:** `users/`
- **Method:** `GET`

#### 5. **Retrieve a User**

- **URL:** `users/:id`
- **Method:** `GET`

#### 6. **Update User**

- **URL:** `users/:id`
- **Method:** `PUT`
- **Request Body:**

```json
{
  "email": "newemail@example.com"
}
```

#### 7. **Delete a User**

- **URL:** `users/:id`
- **Method:** `DELETE`

#### 8. **Create a category**

- **URL:** `categories/`
- **Method:** `POST`
- **Request Body:**

```json
{
  "categoryName": "Pet Foods"
}
```

#### 9. _\*\*Retrieve Categories_

- **URL:** `categories/`
- **Method:** `GET`

#### 10. **Retrieve a category**

- **URL:** `categories/:id`
- **Method:** `GET`

#### 11. **Update a category**

- **URL:** `categories/:id`
- **Method:** `PUT`
- **Request Body:**

```json
{
  "categoryName": "Toys"
}
```

#### 12.**Delete a category**

- **URL:** `categories/:id`
- **Method:** `DELETE`
- **Request Body:**

#### 13.**Create a product**

- **URL:** `products/`
- **Method:** `POST`
- **Request Body:** `**`

```json
{
  "productName": "Dog Chew Toy",
  "description": "Durable chew toy for medium to large dogs",
  "stockQty": 100,
  "purchasingPrice": 5.0,
  "sellingPrice": 10.0,
  "imageUrl": "image1.jpg"
}
```

#### 14.**Retrieve products**

- **URL:** `products/`
- **Method:** `GET`
- **Request Body:** `**`

#### 15.**Retrieve a product**

- **URL:** `products/:id`
- **Method:** `GET`
- **Request Body:** `**`

#### 16.**Update a product**

- **URL:** `products/:id`
- **Method:** `PUT`
- **Request Body:** `**`

```json
{
  "productName": "Interactive Cat Laser Toy",
  "description": "Automatic laser toy to keep cats entertained and active",
  "stockQty": 75,
  "purchasingPrice": 12.0,
  "sellingPrice": 25.0,
  "imageUrl": "http://example.com/images/cat-laser-toy.jpg"
}
```

#### 17.**Delete a product**

- **URL:** `products/:id`
- **Method:** `DELETE`
- **Request Body:**

#### 18.**Create a service**

- **URL:** `services/`
- **Method:** `POST`
- **Request Body:**

```json
{
  "serviceName": "Pet Grooming",
  "description": "Complete grooming service for pets, including bathing, haircuts, and nail trimming",
  "sellingPrice": 40.0,
  "imageUrl": "http://example.com/images/pet-grooming-service.jpg"
}
```

#### 19.**Retrieve services**

- **URL:** `services/`
- **Method:** `GET`
- **Request Body:** `**`

#### 20.**Retrieve a service**

- **URL:** `services/:id`
- **Method:** `GET`
- **Request Body:** `**`

#### 21.**Update a service**

- **URL:** `services/:id`
- **Method:** `PUT`
- **Request Body:** `**`

```json
{
  "sellingPrice": 100.0
}
```

#### 22.**Delete a service**

- **URL:** `services/:id`
- **Method:** `DELETE`
- **Request Body:**

#### 23.**Create a appointment**

- **URL:** `appointments/`
- **Method:** `POST`
- **Request Body:**

```json
{
  "userId": 1,
  "serviceId": 2,
  "additionalInformation": "Routine checkup, vaccinations, and flea treatment.",
  "appointmentDate": "2024-11-15",
  "appointmentTime": "10:00 AM"
}
```

#### 24.**Retrieve appointments**

- **URL:** `appointments/`
- **Method:** `GET`
- **Request Body:** `**`

#### 25.**Retrieve a appointment**

- **URL:** `appointments/:id`
- **Method:** `GET`
- **Request Body:** `**`

#### 26.**Update a appointment**

- **URL:** `appointments/:id`
- **Method:** `PUT`
- **Request Body:** `**`

```json
{
  "additionalInformation": "Routine checkup"
}
```

#### 27.**Delete a appointment**

- **URL:** `appointments/:id`
- **Method:** `DELETE`
- **Request Body:**

#### 28.**Creating a Inventory**

- **URL:** `transactions/`
- **Method:** `POST`
- **Explanation:** Through this endpoint data will be created on Transaction table, Transaction Details and the Payment History tables
- **Request Body:**

```json
{
  "userId": 1,
  "date": "2024-11-19",
  "tax": 15,
  "discount": 5,
  "amountPaid": 105,
  "paymentMethod": "Credit Card",
  "items": [{ "productId": 1, "quantity": 2, "price": 20 }]
}
```

#### 29.**Retrieve transactions**

- **URL:** `transactions/`
- **Method:** `GET`
- **Request Body:** `**`

#### 30.**Retrieve transaction**

- **URL:** `transactions/:id`
- **Method:** `GET`
- **Request Body:** `**`

#### 31.**Update transaction**

- **URL:** `transactions/:id`
- **Method:** `PUT`
- **Request Body:** `**`

```json
{
  "items": [{ "productId": 1, "quantity": 5, "price": 40 }]
}
```

#### 32.**Delete a transaction**

- **URL:** `transactions/:id`
- **Method:** `DELETE`
- **Request Body:**

#### 33.**Retrieve payment histories**

- **URL:** `payments/`
- **Method:** `GET`
- **Request Body:** `**`

#### 34.**Retrieve payment history**

- **URL:** `payments/:id`
- **Method:** `GET`
- **Request Body:** `**`

#### 35.**Communicating with Chatbot**

- **URL:** `chatbot/`
- **Method:** `POST`
- **Request Body:**

```json
{
  "query": "what toy is good for cat"
}
```
