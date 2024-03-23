source setup-cli-env.sh
source setup-agent.sh issuing

cd play/issuing

ln -s ../../fsm/issuing-service-f-fsm.yaml
ln -s ../../fsm/issuing-service-b-fsm.yaml
source ./new-schema
source ./new-cred-def

#./invitation | ../seller/connect
#./invitation | ../buyer/connect
