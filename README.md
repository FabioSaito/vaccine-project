# Vaccination Card
This project aims to expose an API for managing a vaccination system with basic functionalities like registration, deletion and consulting.

## Configurations
* Ruby version: 3.2.2
* Rails version: 7.1.3

## Prerequisite:
`Docker`

## Running the project
### Build image
`$ docker-compose build`

### Run server
`$ docker-compose up`

The server will be running on port `3000`
URL: `localhost:3000`

### Run tests
`$ docker-compose exec web bundle exec rspec`

## Endpoints
### Register vaccine
`POST /api/v1/vaccines`

```
body:
  {
    "name": "Vaccine Name",
    "slug": "unique_identifier"
  }
```

### Register patient
`POST /api/v1/patients`

```
body:
  {
    "name": "Patient Name"
  }
```

### Patient Deletion
`DELETE /api/v1/patients/{patient_id}`

### Register vaccination
`POST /api/v1/vaccinate`

```
body:
  {
    "patient_id": patient_id,
    "vaccine_slug": "vaccine_unique_identifier",
    "vaccine_dose": "vaccine_dose"
  }
```

### Show patient vaccination card
`POST /api/v1/patients/{patient_id}/vaccine_card`

```
response_body_example:
  [
    {
      "name": "Tetra Valente",
      "shot_date": "14-04-2024",
      "dose": "Primeira dose de reforço"
    },
    {
      "name": "BCG",
      "shot_date": "17-04-2024",
      "dose": "Primeira dose"
    }
  ]
```

### Exclude vaccination from patient
`POST /api/v1/vaccinate`

```
body:
  {
    "patient_id": {patient_id},
    "vaccine_slug": "vaccine_slug",
    "vaccine_dose": "vaccine_dose"
  }
```

## Bonus
There is an authentication running on those endpoint
It is a simple JWT that is generated on user creation or retrieved when accessing the corresponding endpoint

### Create user
`POST /signup`

```
body:
  {
    "email": "user@email.com",
    "password": "user_password"
  }
```

### Retrieve JWT
`POST /login`

```
body:
  {
    "email": "user@email.com",
    "password": "user_password"
  }
```

## Diagram
![image](https://github.com/FabioSaito/vaccine-project/assets/29253127/8652b561-20fb-49ba-9f67-478514f07546)

In above diagram, those relations are represented
- `patient` has_one `vaccine_card`
- `vaccine_card` belongs_to `patient`

- `vaccine_cards_vaccines` table holds the association between `vaccine_card` and `vaccine`
- `vaccine_card` and `vaccine` have a `has_and_belongs_to_many` between them


