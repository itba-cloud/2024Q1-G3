import json
import boto3
# Create a DynamoDB object using the AWS SDK
dynamodb = boto3.resource('dynamodb')
# Use the DynamoDB object to select our table
table = dynamodb.Table('Tabla_Vacunas')

# Define the handler function that the Lambda service will use as an entry point
def lambda_handler(event, context):
    # Extract values from the event object we got from the Lambda service and store in variables
    Vacuna_ID = event['Vacuna_ID']
    name = event['name']
    Fecha = event['Fecha']
    
    # Write student data to the DynamoDB table and save the response in a variable
    response = table.put_item(
        Item={
            'Vacuna_ID': Vacuna_ID,
            'name': name,
            'Fecha': Fecha,
        }
    )
    
    # Return a properly formatted JSON object
    return {
        'statusCode': 200,
        'body': json.dumps('Vacuna data saved successfully!')
    }