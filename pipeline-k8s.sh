#Deploy en kubernetes
kubectl apply -f mynginx.yaml && \
--attach

Kubectl run mytests \
--generator=run-pod/v1 \
--image=quimnadalsalle/votingapp-test \
--env VOTINGAPP_HOST=myvotingapp.votingapp \
--rm --attach --restart=Never
#(--rm es para eliminarse al acabar, --attach para que me de el resultado de la ejecución)

echo "GREEN" || echo "RED"