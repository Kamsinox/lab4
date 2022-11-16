FROM alpine
RUN echo "BuildKit – how it works " > question.txt
CMD ["/bin/sh"]