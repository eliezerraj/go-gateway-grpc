# go-gateway-grpc
worklod for POC purposes

# make load 
make -C /mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/ load_all

# usecase
    AddPaymentToken(GRPC)
    request a authorization via GRPC to go-payment-authorizer

    AddPayment
    request a authorization via REST to go-payment-gateway SYNCH

    PixTransaction
    request a authorization via REST to go-payment-gateway

# table
    create a transaction ID
    SELECT uuid_generate_v4()

    