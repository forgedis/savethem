import 'package:appwrite/appwrite.dart';

Client client = Client()
.setEndpoint('http://165.227.173.112/v1') // Your Appwrite Endpoint
.setProject('638e0c4c8987dca18b77')         // Your project ID
.setSelfSigned(status: true);        // For self signed certificates, only use for development