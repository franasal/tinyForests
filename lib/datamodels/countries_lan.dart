Map<String, Map<String, String>> countriesTrans = {
  'Eritrea': {'es': 'Eritrea', 'de': 'Eritrea'},
  'Belgium': {'es': 'Bélgica', 'de': 'Belgien'},
  'Washington': {'es': 'Washington', 'de': 'Washington'},
  'New Jersey': {'es': 'New Jersey', 'de': 'New Jersey'},
  'Norway': {'es': 'Noruega', 'de': 'Norwegen'},
  'Turkey-in-Europe': {'es': 'Turquía en Europa', 'de': 'Türkei-in-Europa'},
  'Cape Provinces': {'es': 'Provincias del Cabo', 'de': 'Kapprovinzen'},
  'Rhode I.': {'es': 'Roda I.', 'de': 'Rhode I.'},
  'Kazakhstan': {'es': 'Kazajstán', 'de': 'Kasachstan'},
  'Greenland': {'es': 'Groenlandia', 'de': 'Grönland'},
  'Montana': {'es': 'Montana', 'de': 'Montana'},
  'West Virginia': {'es': 'Virginia del Oeste', 'de': 'West Virginia'},
  'Sweden': {'es': 'Suecia', 'de': 'Schweden'},
  'Philippines': {'es': 'Filipinas', 'de': 'Philippinen'},
  'South Australia': {'es': 'Sur de Australia', 'de': 'Süd Australien'},
  'West Himalaya': {'es': 'Himalaya occidental', 'de': 'West-Himalaya'},
  'Hungary': {'es': 'Hungría', 'de': 'Ungarn'},
  'New Hampshire': {'es': 'Nuevo Hampshire', 'de': 'New Hampshire'},
  'Ecuador': {'es': 'Ecuador', 'de': 'Ecuador'},
  'Italy': {'es': 'Italia', 'de': 'Italien'},
  'Afghanistan': {'es': 'Afganistán', 'de': 'Afghanistan'},
  'Michigan': {'es': 'Michigan', 'de': 'Michigan'},
  'Taiwan': {'es': 'Taiwán', 'de': 'Taiwan'},
  'Mexico Northwest': {'es': 'México Noroeste', 'de': 'Mexiko Nordwesten'},
  'Iowa': {'es': 'Iowa', 'de': 'Iowa'},
  'Germany': {'es': 'Alemania', 'de': 'Deutschland'},
  'Utah': {'es': 'Utah', 'de': 'Utah'},
  'Czechoslovakia': {'es': 'Checoslovaquia', 'de': 'Tschechoslowakei'},
  'Saudi Arabia': {'es': 'Arabia Saudita', 'de': 'Saudi-Arabien'},
  'Idaho': {'es': 'Idaho', 'de': 'Idaho'},
  'North Carolina': {'es': 'Carolina del Norte', 'de': 'North Carolina'},
  'Yemen': {'es': 'Yemen', 'de': 'Jemen'},
  'South European Russi': {
    'es': 'Rusia del sur de Europa',
    'de': 'Südeuropäisches Russland'
  },
  'Turkmenistan': {'es': 'Turkmenistán', 'de': 'Turkmenistan'},
  'Yugoslavia': {'es': 'Yugoslavia', 'de': 'Jugoslawien'},
  'Swaziland': {'es': 'Suazilandia', 'de': 'Swasiland'},
  'Tadzhikistan': {'es': 'Tayikistán', 'de': 'Tadschikistan'},
  'Missouri': {'es': 'Misuri', 'de': 'Missouri'},
  'Oregon': {'es': 'Oregón', 'de': 'Oregon'},
  'Pennsylvania': {'es': 'Pensilvania', 'de': 'Pennsylvania'},
  'Tennessee': {'es': 'Tennesse', 'de': 'Tennessee'},
  'Iran': {'es': 'Irán', 'de': 'Iran'},
  'France': {'es': 'Francia', 'de': 'Frankreich'},
  'Mongolia': {'es': 'Mongolia', 'de': 'Mongolei'},
  'Bangladesh': {'es': 'Bangladesh', 'de': 'Bangladesch'},
  'Netherlands': {'es': 'Países Bajos', 'de': 'Niederlande'},
  'Ontario': {'es': 'ontario', 'de': 'Ontario'},
  'Virginia': {'es': 'Virginia', 'de': 'Virginia'},
  'Poland': {'es': 'Polonia', 'de': 'Polen'},
  'Connecticut': {'es': 'Connecticut', 'de': 'Connecticut'},
  'Baltic States': {'es': 'Estados bálticos', 'de': 'Baltische Staaten'},
  'Vermont': {'es': 'Vermont', 'de': 'Vermont'},
  'Madagascar': {'es': 'Madagascar', 'de': 'Madagaskar'},
  'Ohio': {'es': 'Ohio', 'de': 'Ohio'},
  'South Carolina': {'es': 'Carolina del Sur', 'de': 'South Carolina'},
  'Sudan': {'es': 'Sudán', 'de': 'Sudan'},
  'California': {'es': 'California', 'de': 'Kalifornien'},
  'Albania': {'es': 'Albania', 'de': 'Albanien'},
  'Denmark': {'es': 'Dinamarca', 'de': 'Dänemark'},
  'Transcaucasus': {'es': 'Transcáucaso', 'de': 'Transkaukasus'},
  'Kansas': {'es': 'Kansas', 'de': 'Kansas'},
  'Portugal': {'es': 'Portugal', 'de': 'Portugal'},
  'Romania': {'es': 'Rumania', 'de': 'Rumänien'},
  'Iceland': {'es': 'Islandia', 'de': 'Island'},
  'Cyprus': {'es': 'Chipre', 'de': 'Zypern'},
  'British Columbia': {'es': 'Columbia Británica', 'de': 'Britisch-Kolumbien'},
  'Texas': {'es': 'Texas', 'de': 'Texas'},
  'Falkland Is.': {'es': 'Islas Malvinas.', 'de': 'Falklandinseln.'},
  'Uruguay': {'es': 'Uruguay', 'de': 'Uruguay'},
  'Maine': {'es': 'Maine', 'de': 'Maine'},
  'Iraq': {'es': 'Irak', 'de': 'Irak'},
  'Bolivia': {'es': 'bolivia', 'de': 'Bolivien'},
  'Florida': {'es': 'Florida', 'de': 'Florida'},
  'Libya': {'es': 'Libia', 'de': 'Libyen'},
  'Nepal': {'es': 'Nepal', 'de': 'Nepal'},
  'Tunisia': {'es': 'Túnez', 'de': 'Tunesien'},
  'Kentucky': {'es': 'Kentucky', 'de': 'Kentucky'},
  'Greece': {'es': 'Grecia', 'de': 'Griechenland'},
  'East Aegean Is.': {
    'es': 'Islas del Egeo Oriental.',
    'de': 'Östliche Ägäisinseln.'
  },
  'Indiana': {'es': 'Indiana', 'de': 'Indiana'},
  'New Mexico': {'es': 'Nuevo Mexico', 'de': 'New-Mexiko'},
  'Delaware': {'es': 'Delaware', 'de': 'Delaware'},
  'India': {'es': 'India', 'de': 'Indien'},
  'Lesotho': {'es': 'Lesoto', 'de': 'Lesotho'},
  'Spain': {'es': 'España', 'de': 'Spanien'},
  'Illinois': {'es': 'Illinois', 'de': 'Illinois'},
  'New York': {'es': 'Nueva York', 'de': 'New York'},
  'Sri Lanka': {'es': 'Sri Lanka', 'de': 'Sri Lanka'},
  'Krym': {'es': 'krym', 'de': 'Krym'},
  'Canary Is.': {'es': 'Islas Canarias.', 'de': 'Kanarische Inseln.'},
  'Nova Scotia': {'es': 'nueva Escocia', 'de': 'Neuschottland'},
  'East Himalaya': {'es': 'Himalaya oriental', 'de': 'Ost-Himalaya'},
  'Uzbekistan': {'es': 'Uzbekistán', 'de': 'Usbekistan'},
  'Ukraine': {'es': 'Ucrania', 'de': 'Ukraine'},
  'Wisconsin': {'es': 'Wisconsin', 'de': 'Wisconsin'},
  'Georgia': {'es': 'Georgia', 'de': 'Georgia'},
  'Bulgaria': {'es': 'Bulgaria', 'de': 'Bulgarien'},
  'Corse': {'es': 'Córcega', 'de': 'Korsika'},
  'Maryland': {'es': 'Maryland', 'de': 'Maryland'},
  'Switzerland': {'es': 'Suiza', 'de': 'Schweiz'},
  'Great Britain': {'es': 'Gran Bretaña', 'de': 'Großbritannien'},
  'Japan': {'es': 'Japón', 'de': 'Japan'},
  'East European Russia': {
    'es': 'Rusia de Europa del Este',
    'de': 'Osteuropäisches Russland'
  },
  'Palestine': {'es': 'Palestina', 'de': 'Palästina'},
  'Sardegna': {'es': 'Cerdeña', 'de': 'Sardinien'},
  'North Caucasus': {'es': 'Cáucaso Norte', 'de': 'Nordkaukasus'},
  'Free State': {'es': 'Estado libre', 'de': 'Freier Staat'},
  'Algeria': {'es': 'Argelia', 'de': 'Algerien'},
  'Morocco': {'es': 'Marruecos', 'de': 'Marokko'},
  'Korea': {'es': 'Corea', 'de': 'Korea'},
  'Mississippi': {'es': 'Misisipí', 'de': 'Mississippi'},
  'Oklahoma': {'es': 'Oklahoma', 'de': 'Oklahoma'},
  'Sicilia': {'es': 'Sicilia', 'de': 'Sizilien'},
  'Arkansas': {'es': 'Arkansas', 'de': 'Arkansas'},
  'Austria': {'es': 'Austria', 'de': 'Österreich'},
  'Myanmar': {'es': 'Birmania', 'de': 'Myanmar'},
  'Belarus': {'es': 'Bielorrusia', 'de': 'Weißrussland'},
  'Turkey': {'es': 'Pavo', 'de': 'Truthahn'},
  'Kriti': {'es': 'criti', 'de': 'Kriti'},
  'Finland': {'es': 'Finlandia', 'de': 'Finnland'},
  'Central European Rus': {
    'es': 'Rusia centroeuropea',
    'de': 'Mitteleuropäisches Russland'
  },
  'Pakistan': {'es': 'Pakistán', 'de': 'Pakistan'},
  'Ireland': {'es': 'Irlanda', 'de': 'Irland'},
  'Louisiana': {'es': 'Luisiana', 'de': 'Louisiana'},
  'Alabama': {'es': 'Alabama', 'de': 'Alabama'}
};