Campus Connect 
Det är en mobilapp som hjälper studenter på Campus Valla att snabbt hitta studieplatser, kafeer och andra relevanta samlingspunkter i närheten. Appen gör det enklare att upptäcka nya platser, hitta vänner och planera studietid mer effektivt.
Appens huvudsakliga funktion är att visa en karta över campusområdet och markerar ut olika studieplatser och kaféer. Användare kan logga in med sitt Google-konto och se vilka platser som finns i närheten.

Krav jag demonstrerade för på 17/12/2025:

Tekniska krav att välja från:
    Alla sidor (widgets) är självtillräckliga, dvs. det finns inga sidvisa länkar i widget trädet, från en gren till en annan. Varje widget hanterar (lagrar och uppdaterar) sitt eget innehåll och sitt eget tillstånd, istället för att detta hanteras i appens globala tillstånd (app state) -- så långt detta är möjligt. (1 p)
    
    Använder forms och validerar användarinput, så att input är av rätt typ, och är korrekt. T.ex. att lösenord är tillräcklig starka. (2 p)
    
    Enkel inloggning av användare mot Firebase (1 p)
    
    Visar realtidsuppdatering av skärminnehåll från Firestore eller motsvarande backend, så att t.ex. en användare kan se i realtid vad en annan användare har skrivit eller gjort. (1 p)
    Total: 5 technical points 

Entreprenöriella krav att välja från
    Firestore. Använder Cloud Firestore eller Realtime Database som databas. Båda lösningarna är Googles lagringstjänst för mobile- och webb-appar som erbjuder bl.a. databas och autentisering. Dessutom finns en mer generell databas-lösning som heter Firebase Cloud Storage. Cloud Storage accepterar både ljud, bild, och text så i princip alla appar kan utnyttja Cloud Storage på ett eller annat sätt. (2p)

    Sökfunktion i appen, dvs. att användaren kan skriva in ett sökord och få upp relevant information. Oftast krävs att sökningen genomförs på backend-sidan, för att säkerställa att all relevant information kan visas, inte bara det som råkade finnas på skrämen.(2p)
    Total: 4 entrepreneurial points 


