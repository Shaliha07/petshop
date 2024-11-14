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
#### 9. ***Retrive Categories*

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
  "purchasingPrice": 5.00,
  "sellingPrice": 10.00,
  "imageUrl": "image1.jpg"
}
```
#### 14.**Retrive products**

- **URL:** `products/`
- **Method:** `GET`
- **Request Body:** `**`

#### 15.**Retrive a product**

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
  "purchasingPrice": 12.00,
  "sellingPrice": 25.00,
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
  "sellingPrice": 40.00,
  "imageUrl": "http://example.com/images/pet-grooming-service.jpg"
}
```
#### 19.**Retrive services**

- **URL:** `services/`
- **Method:** `GET`
- **Request Body:** `**`

#### 20.**Retrive a service**

- **URL:** `services/:id`
- **Method:** `GET`
- **Request Body:** `**`

#### 21.**Update a service**

- **URL:** `services/:id`
- **Method:** `PUT`
- **Request Body:** `**`

```json
{
  "sellingPrice": 100.00
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
#### 19.**Retrive appointments**

- **URL:** `appointments/`
- **Method:** `GET`
- **Request Body:** `**`

#### 20.**Retrive a appointment**

- **URL:** `appointments/:id`
- **Method:** `GET`
- **Request Body:** `**`

#### 21.**Update a appointment**

- **URL:** `appointments/:id`
- **Method:** `PUT`
- **Request Body:** `**`

```json
{
    "additionalInformation": "Routine checkup"
}
```

#### 22.**Delete a appointment**

- **URL:** `appointments/:id`
- **Method:** `DELETE`
- **Request Body:**









