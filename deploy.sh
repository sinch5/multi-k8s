docker build -t sinch5/multi-client:latest -t sinch5/multi-client:$SHA -f./client/Dockerfile ./client
docker build -t sinch5/multi-server:latest -t sinch5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sinch5/multi-worker:latest -t sinch5/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sinch5/multi-client:latest
docker push sinch5/multi-server:latest
docker push sinch5/multi-worker:latest

docker push sinch5/multi-client:$SHA
docker push sinch5/multi-server:$SHA
docker push sinch5/multi-worker:$SHA
kubectl -f k8s
kubectl set image deployments/server-deployment server=sinch5/multi-server:$SHA
kubectl set image deployments/client-deployment client=sinch5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sinch5/multi-worker:$SHA