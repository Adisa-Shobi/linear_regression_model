from fastapi import FastAPI, HTTPException
import pickle
from fastapi.middleware.cors import CORSMiddleware as CORS
from models.gdp_input import GDPInput
import pandas as pd
import sklearn
# Import env
from dotenv import load_dotenv

model_path = 'Best Model.pkl'
app = FastAPI()


def load_model():
    try:
        with open(model_path, 'rb') as file:
            model = pickle.load(file)
        return model
    except FileNotFoundError:
        print("Error: Model not found")
    except Exception as e:
        print(f"Error: {e}")


data_columns = ['agricultural_land',
                'forest_land',
                'land_area',
                'avg_precipitation',
                'trade_in_services',
                'control_of_corruption_estimate',
                'control_of_corruption_std',
                'access_to_electricity',
                'electric_power_consumption',
                'population_density',
                'inflation_annual',
                'real_interest_rate',
                'risk_premium_on_lending',
                'research_and_development_expenditure',
                'central_goverment_debt',
                'tax_revenue',
                'human_capital_index',
                'doing_business',
                'time_to_get_operation_license',
                'statistical_performance_indicators',
                'individuals_using_internet',
                'logistic_performance_index',
                'military_expenditure',
                'government_expenditure_on_education',
                'government_health_expenditure',
                'multidimensional_poverty_headcount_ratio',
                'gini_index',
                'intentional_homicides',
                'country_Afghanistan',
                'country_Africa Eastern and Southern',
                'country_Africa Western and Central',
                'country_Albania',
                'country_Algeria',
                'country_American Samoa',
                'country_Andorra',
                'country_Angola',
                'country_Antigua and Barbuda',
                'country_Arab World',
                'country_Argentina',
                'country_Armenia',
                'country_Aruba',
                'country_Australia',
                'country_Austria',
                'country_Azerbaijan',
                'country_Bahamas, The',
                'country_Bahrain',
                'country_Bangladesh',
                'country_Barbados',
                'country_Belarus',
                'country_Belgium',
                'country_Belize',
                'country_Benin',
                'country_Bermuda',
                'country_Bhutan',
                'country_Bolivia',
                'country_Bosnia and Herzegovina',
                'country_Botswana',
                'country_Brazil',
                'country_Brunei Darussalam',
                'country_Bulgaria',
                'country_Burkina Faso',
                'country_Burundi',
                'country_Cabo Verde',
                'country_Cambodia',
                'country_Cameroon',
                'country_Canada',
                'country_Caribbean small states',
                'country_Cayman Islands',
                'country_Central African Republic',
                'country_Central Europe and the Baltics',
                'country_Chad',
                'country_Channel Islands',
                'country_Chile',
                'country_China',
                'country_Colombia',
                'country_Comoros',
                'country_Congo, Dem. Rep.',
                'country_Congo, Rep.',
                'country_Costa Rica',
                "country_Cote d'Ivoire",
                'country_Croatia',
                'country_Cuba',
                'country_Curacao',
                'country_Cyprus',
                'country_Czechia',
                'country_Denmark',
                'country_Djibouti',
                'country_Dominica',
                'country_Dominican Republic',
                'country_Early-demographic dividend',
                'country_East Asia & Pacific',
                'country_East Asia & Pacific (IDA & IBRD countries)',
                'country_East Asia & Pacific (excluding high income)',
                'country_Ecuador',
                'country_Egypt, Arab Rep.',
                'country_El Salvador',
                'country_Equatorial Guinea',
                'country_Eritrea',
                'country_Estonia',
                'country_Eswatini',
                'country_Ethiopia',
                'country_Euro area',
                'country_Europe & Central Asia',
                'country_Europe & Central Asia (IDA & IBRD countries)',
                'country_Europe & Central Asia (excluding high income)',
                'country_European Union',
                'country_Faroe Islands',
                'country_Fiji',
                'country_Finland',
                'country_Fragile and conflict affected situations',
                'country_France',
                'country_French Polynesia',
                'country_Gabon',
                'country_Gambia, The',
                'country_Georgia',
                'country_Germany',
                'country_Ghana',
                'country_Greece',
                'country_Greenland',
                'country_Grenada',
                'country_Guam',
                'country_Guatemala',
                'country_Guinea',
                'country_Guinea-Bissau',
                'country_Guyana',
                'country_Haiti',
                'country_Heavily indebted poor countries (HIPC)',
                'country_High income',
                'country_Honduras',
                'country_Hong Kong SAR, China',
                'country_Hungary',
                'country_IBRD only',
                'country_IDA & IBRD total',
                'country_IDA blend',
                'country_IDA only',
                'country_IDA total',
                'country_Iceland',
                'country_India',
                'country_Indonesia',
                'country_Iran, Islamic Rep.',
                'country_Iraq',
                'country_Ireland',
                'country_Isle of Man',
                'country_Israel',
                'country_Italy',
                'country_Jamaica',
                'country_Japan',
                'country_Jordan',
                'country_Kazakhstan',
                'country_Kenya',
                'country_Kiribati',
                'country_Korea, Rep.',
                'country_Kosovo',
                'country_Kuwait',
                'country_Kyrgyz Republic',
                'country_Lao PDR',
                'country_Late-demographic dividend',
                'country_Latin America & Caribbean',
                'country_Latin America & Caribbean (excluding high income)',
                'country_Latin America & the Caribbean (IDA & IBRD countries)',
                'country_Latvia',
                'country_Least developed countries: UN classification',
                'country_Lebanon',
                'country_Lesotho',
                'country_Liberia',
                'country_Libya',
                'country_Liechtenstein',
                'country_Lithuania',
                'country_Low & middle income',
                'country_Low income',
                'country_Lower middle income',
                'country_Luxembourg',
                'country_Macao SAR, China',
                'country_Madagascar',
                'country_Malawi',
                'country_Malaysia',
                'country_Maldives',
                'country_Mali',
                'country_Malta',
                'country_Marshall Islands',
                'country_Mauritania',
                'country_Mauritius',
                'country_Mexico',
                'country_Micronesia, Fed. Sts.',
                'country_Middle East & North Africa',
                'country_Middle East & North Africa (IDA & IBRD countries)',
                'country_Middle East & North Africa (excluding high income)',
                'country_Middle income',
                'country_Moldova',
                'country_Monaco',
                'country_Mongolia',
                'country_Montenegro',
                'country_Morocco',
                'country_Mozambique',
                'country_Myanmar',
                'country_Namibia',
                'country_Nauru',
                'country_Nepal',
                'country_Netherlands',
                'country_New Caledonia',
                'country_New Zealand',
                'country_Nicaragua',
                'country_Niger',
                'country_Nigeria',
                'country_North America',
                'country_North Macedonia',
                'country_Northern Mariana Islands',
                'country_Norway',
                'country_OECD members',
                'country_Oman',
                'country_Other small states',
                'country_Pacific island small states',
                'country_Pakistan',
                'country_Palau',
                'country_Panama',
                'country_Papua New Guinea',
                'country_Paraguay',
                'country_Peru',
                'country_Philippines',
                'country_Poland',
                'country_Portugal',
                'country_Post-demographic dividend',
                'country_Pre-demographic dividend',
                'country_Puerto Rico',
                'country_Qatar',
                'country_Romania',
                'country_Russian Federation',
                'country_Rwanda',
                'country_Samoa',
                'country_San Marino',
                'country_Sao Tome and Principe',
                'country_Saudi Arabia',
                'country_Senegal',
                'country_Serbia',
                'country_Seychelles',
                'country_Sierra Leone',
                'country_Singapore',
                'country_Sint Maarten (Dutch part)',
                'country_Slovak Republic',
                'country_Slovenia',
                'country_Small states',
                'country_Solomon Islands',
                'country_Somalia',
                'country_South Africa',
                'country_South Asia',
                'country_South Asia (IDA & IBRD)',
                'country_South Sudan',
                'country_Spain',
                'country_Sri Lanka',
                'country_St. Kitts and Nevis',
                'country_St. Lucia',
                'country_St. Martin (French part)',
                'country_St. Vincent and the Grenadines',
                'country_Sub-Saharan Africa',
                'country_Sub-Saharan Africa (IDA & IBRD countries)',
                'country_Sub-Saharan Africa (excluding high income)',
                'country_Sudan',
                'country_Suriname',
                'country_Sweden',
                'country_Switzerland',
                'country_Syrian Arab Republic',
                'country_Tajikistan',
                'country_Tanzania',
                'country_Thailand',
                'country_Timor-Leste',
                'country_Togo',
                'country_Tonga',
                'country_Trinidad and Tobago',
                'country_Tunisia',
                'country_Turkiye',
                'country_Turkmenistan',
                'country_Turks and Caicos Islands',
                'country_Tuvalu',
                'country_Uganda',
                'country_Ukraine',
                'country_United Arab Emirates',
                'country_United Kingdom',
                'country_United States',
                'country_Upper middle income',
                'country_Uruguay',
                'country_Uzbekistan',
                'country_Vanuatu',
                'country_Venezuela, RB',
                'country_Viet Nam',
                'country_Virgin Islands (U.S.)',
                'country_West Bank and Gaza',
                'country_World',
                'country_Yemen, Rep.',
                'country_Zambia',
                'country_Zimbabwe']


def load_data():
    data = pd.read_csv(
        'data\world_bank_development_indicators.csv')
    return data


def convert_input_to_binary(input_data, all_countries, X_columns):
    """
    Convert input data to binary format with proper country encoding

    Parameters:
    -----------
    input_data : dict
        Input data containing country and other features
    all_countries : list
        List of all countries from training data
    X_columns : list
        List of all columns from training data (including encoded countries)

    Returns:
    --------
    pd.DataFrame
        Encoded input data aligned with training columns
    """
    # Create initial DataFrame from input data
    input_df = pd.DataFrame([input_data])

    # Get the country value before dropping it
    country = input_data['country']

    # Create a DataFrame for non-country columns
    non_country_cols = [col for col in input_df.columns if col != 'country']
    base_df = input_df[non_country_cols]

    # Create country encoding DataFrame
    country_data = {f'country_{c}': [
        1 if c == country else 0] for c in all_countries}
    country_df = pd.DataFrame(country_data)

    # Combine base features and country encoding
    result_df = pd.concat([base_df, country_df], axis=1)

    # Ensure all expected columns are present with 0s for missing ones
    missing_cols = set(X_columns) - set(result_df.columns)
    if missing_cols:
        missing_df = pd.DataFrame(
            0, index=result_df.index, columns=list(missing_cols))
        result_df = pd.concat([result_df, missing_df], axis=1)

    # Ensure columns are in the same order as training data
    result_df = result_df[X_columns]

    return result_df


def load_env():
    return load_dotenv()


def get_allowed_origins():
    '''
    Load allowed origins from environment variables and return a list of origins
    '''
    try:
        env = load_env()
        origins_str = env.get('ALLOWED_ORIGINS', '')
        if not origins_str:
            return ['http://localhost:3000']  # Default fallback

        allowed_origins = [
            origin.strip()
            for origin in origins_str.split(',')
            if origin.strip()
        ]

        # Validate origins format
        for origin in allowed_origins:
            if not (origin.startswith('http://') or origin.startswith('https://')):
                raise ValueError(f"Invalid origin format: {origin}")

        return allowed_origins

    except Exception as e:
        return ['http://localhost:3000']  # Fallback to safe default


app.add_middleware(
    CORS,
    allow_origins=get_allowed_origins(),
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

GDPInput.valid_countries = load_data()['country'].unique().tolist()


@app.post('/predict')
def predict_gdp_per_capita(input: GDPInput):
    """
    Predict GDP per capita based on input features
    """
    # Load the model
    model = load_model()
    print('======================== Model Loaded ========================')

    try:
        input_data = input.dict()
        # print(input_data)
        binary_data = convert_input_to_binary(
            input_data, GDPInput.valid_countries, data_columns)

        # Make prediction
        print(len(binary_data.columns.tolist()))
        prediction = model['model'].predict(binary_data)

        return {"prediction": {'log10_GDP_per_cap': prediction[0]}}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@app.get('/countries')
def get_countries():
    """
    Get a list of all countries
    """
    return {"countries": GDPInput.valid_countries}
