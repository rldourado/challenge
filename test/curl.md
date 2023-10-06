
### GET posts

```
$ curl --location 'localhost:3000/posts'
```

### GET posts/:id

```
$ curl --location 'localhost:3000/posts/1'
```

### POST /posts

```
$ curl --location 'localhost:3000/posts' \
       --header 'Content-Type: application/json' \
       --data '{
           "title": "Teste",
           "text": "Teste"
       }'
```
