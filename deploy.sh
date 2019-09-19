docker build -t martinsak/multi-client:latest -t martinsak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t martinsak/multi-server:latest -t martinsak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t martinsak/multi-worker:latest -t martinsak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push martinsak/multi-client:latest
docker push martinsak/multi-server:latest
docker push martinsak/multi-worker:latest

docker push martinsak/multi-client:$SHA
docker martinsak/multi-server:$SHA
docker martinsak/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=martinsak/multi-server:$SHA
kubectl set image deployments/client-deployment client=martinsak/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=martinsak/multi-worker:$SHA


