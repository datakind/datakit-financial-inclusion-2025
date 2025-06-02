Fetches data from both APIs
Cleans and structures the data
Appends the datasets into a unified format
As an example, I pulled population data and instant payment (PIX) transaction data — and there's a lot of potential to create new variables by combining both sources.


Based on my experience working with Brazilian data, we can source most of the relevant information from two main institutions: the IBGE (Brazilian Institute of Geography and Statistics) and the Central Bank of Brazil. Both provide good APIs, and we can use the IBGE’s municipality id to easily join datasets at the local level.