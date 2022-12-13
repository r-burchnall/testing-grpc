package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	"google.golang.org/grpc"
	pb "rpc-server/pkg/hello-world/protos"
)

var (
	port = flag.Int("port", 50051, "The server port")
)

type server struct {
	pb.UnimplementedChatterServer
}

var _ pb.ChatterServer = &server{}

func (s *server) GetMessage(ctx context.Context, in *pb.GetMessageRequest) (*pb.GetMessageResponse, error) {
	log.Printf("Received: %v", in.GetName())
	return &pb.GetMessageResponse{Name: "Hello " + in.GetName()}, nil
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterChatterServer(s, &server{})
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
