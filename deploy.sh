docker build -t engkarimahmed/multi-client:latest -t engkarimahmed/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t engkarimahmed/multi-server:latest -t engkarimahmed/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t engkarimahmed/multi-worker:latest -t engkarimahmed/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push engkarimahmed/multi-client:latest
docker push engkarimahmed/multi-client:$SHA
docker push engkarimahmed/multi-server:latest
docker push engkarimahmed/multi-server:$SHA
docker push engkarimahmed/multi-worker:latest
docker push engkarimahmed/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=engkarimahmed/multi-server:$SHA
kubectl set image deployments/client-deployment client=engkarimahmed/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=engkarimahmed/multi-worker:$SHA
