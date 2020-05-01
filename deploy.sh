
docker build -t youngsingtan/multi-client:latest -t youngsingtan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t youngsingtan/multi-server:latest -t youngsingtan/multi-client:$SHA -f ./server/Dockerfile ./server
docker build -t youngsingtan/multi-worker:latest -t youngsingtan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push youngsingtan/multi-client:latest
docker push youngsingtan/multi-client:$SHA

docker push youngsingtan/multi-server:latest
docker push youngsingtan/multi-server:$SHA

docker push youngsingtan/multi-worker:latest
docker push youngsingtan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=youngsingtan/multi-server:$SHA
kubectl set image deployments/client-deployment client=youngsingtan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=youngsingtan/multi-worker:$SHA