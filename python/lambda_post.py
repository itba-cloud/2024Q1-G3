import json
import boto3


dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('Tabla_Vacunas')


def lambda_handler(event, context):
    Vacuna_ID = event['Vacuna_ID']
    name = event['name']
    Fecha = event['Fecha']
    

    response = table.put_item(
        Item={
            'Vacuna_ID': Vacuna_ID,
            'name': name,
            'Fecha': Fecha,
        }
    )
    
    
    return {
        'statusCode': 200,
        'body': json.dumps('Vacuna data saved successfully!')
    }
