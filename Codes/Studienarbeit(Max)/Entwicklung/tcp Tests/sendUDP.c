#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fcntl.h>
#include <netdb.h>
#include <sys/time.h>
#include <arpa/inet.h>
#include <time.h>
#include <errno.h>

#define PORT (54096)

#define SUBIMAGES (1000)
#define FRAMES_PER_SUBIMAGES (23)
#define UDP_FRAME (1442)

#define SERVERADDRESS "192.168.178.25" // 138.131.156.36"

#define BUFFER_SIZE (SUBIMAGES * FRAMES_PER_SUBIMAGES * UDP_FRAME)


char buffer[BUFFER_SIZE];

/**
 * Populate the buffer with random data.
 */
void build(uint8_t* buffer, size_t length)
{
    for (size_t i = 0; i < length; i++)
    {
        buffer[i] = (rand() % 255) + 1;
    }
}

int main(int argc, char **argv)
{
    struct timespec start, end;
    int sockfd;
    struct sockaddr_in server;

    printf("Build Data...\n");
    build(buffer, sizeof(buffer));

    printf("Configure socket...\n");
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0)
    {
        fprintf(stderr, "Error opening socket");
        return EXIT_FAILURE;
    }

    bzero((char*)&server, sizeof(server));
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr(SERVERADDRESS);
    server.sin_port = htons(PORT);

    printf("Send UDP data...\n");
    clock_gettime(CLOCK_MONOTONIC_RAW, &start);
    for (size_t i = 0; i < BUFFER_SIZE; i += UDP_FRAME)
    {
        if (sendto(sockfd, &buffer[i], UDP_FRAME, 0,
                   (const struct sockaddr*)&server, sizeof(server)) < 0)
        {
            fprintf(stderr, "Error in sendto()\n");
            return EXIT_FAILURE;
        }
    }
    clock_gettime(CLOCK_MONOTONIC_RAW, &end);
    uint64_t delta_us = (end.tv_sec - start.tv_sec) * 1000000 +
                        (end.tv_nsec - start.tv_nsec) / 1000;

    printf("Time to send %d subimages: %f[s]\n", SUBIMAGES, delta_us / 1e6f);
    printf("Finished...\n");

    return EXIT_SUCCESS;
}