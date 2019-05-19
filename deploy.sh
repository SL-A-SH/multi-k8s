docker build -t aqeebrizwan/multi-client:latest -t aqeebrizwan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aqeebrizwan/multi-server:latest -t aqeebrizwan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aqeebrizwan/multi-worker:latest -t aqeebrizwan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aqeebrizwan/multi-client:latest
docker push aqeebrizwan/multi-server:latest
docker push aqeebrizwan/multi-worker:latest

docker push aqeebrizwan/multi-client:$SHA
docker push aqeebrizwan/multi-server:$SHA
docker push aqeebrizwan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aqeebrizwan/multi-server:$SHA
kubectl set image deployments/client-deployment client=aqeebrizwan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aqeebrizwan/multi-worker:$SHA