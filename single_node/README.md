## Docker File Build

```bash
docker build --tag single_node .
```

# Docker Run

```bash
docker run -d -p 7077:7077 -p 8080:8080 -p 8081:8081 -v D:/mount:/mount --name single_node single_node
```
