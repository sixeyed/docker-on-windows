FROM microsoft/dotnet:1.1.0-runtime-nanoserver

EXPOSE 5000
ENV NERD_DINNER_URL="/home/find"

WORKDIR /dotnetapp
COPY dotnetapp .

CMD ["dotnet", "NerdDinnerHomepage.dll", "--server.urls", "http://*:5000"]