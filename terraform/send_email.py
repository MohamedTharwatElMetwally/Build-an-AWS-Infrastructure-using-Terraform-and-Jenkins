import boto3
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    # TODO implement
    
    try:
        sesclient = boto3.client('ses')
        subject = "From AWS"
        body = "the state file is changed."
        message = {
            "Subject": {
                "Data": subject
            },
            "Body": {
                "Text": {
                    "Data": body
                }
            }
        }
        sesclient.send_email(Source="mt2910201@gmail.com", Destination={"ToAddresses": ["mt2910201@gmail.com",]}, Message=message)

    except Exception as e:
        logger.error(e)
        print(e)


    # save logs
    logger.info(f"message was sent Successfully.")
    
    