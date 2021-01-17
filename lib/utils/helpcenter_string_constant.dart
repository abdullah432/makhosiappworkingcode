import 'package:flutter/foundation.dart';

class HelpCenterStringConstant {
  //general questions
  //question 1
  static const String question1 = '1.	Where can I find the Mkhosi App?';
  static const String answer1 =
      'Answer: Mkhosi can be found on all iOS and Android phones under iStore and Playstores.';
  //question 2
  static const String question2 =
      '2.	Where can I learn more about the Mkhosi App and setting it up?';
  static const String answer2 =
      'Answer: Mkhosi has a YouTube channel with tutorials on all aspects of setting up an using the App';
  //question 3
  static const String question3 =
      '3.	What does the name “Mkhosi” mean and where does it come from?';
  static const String answer3 =
      '''Answer: Mkhosi is shortened from “Hlaba umkhosi” which comes from the isiZulu language of South Africa which has multiple meanings including to send an SOS or to call for help or assistance or the clarion call. On its own, “Mkhosi” can mean a ceremony or festival as well as an army battalion. 
Applying this name to the App is because when you run a small business on your own, there are times when you feel like you need an army to assist you just to get through the daily tasks and to make sense of the do’s and don’ts of running your business. With that, when you have success, it does feel like there is a cause for a celebration, a festival. Our hope is that Mkhosi is able to support you in your journey to a sustainable business, being the support you need when the going gets tough and the community that is always there to celebrate with you when the plan falls into place.
''';
//question 4
  static const String question4 = '4.	Who is the target audience for Mkhosi?';
  static const String answer4 =
      'Answer: Mkhosi is primarily targeting small and micro service based businesses with one employee who is also the owner. It is for those who love what they do but find themselves overwhelmed at times by all the requirements of running a business including booking of clients, record keeping and documentation, maintaining a database of their clients and remembering to provide that personal touch which will make clients select you and your small business even if there are bigger more well known companies providing the same or similar services. ';
  //question 5
  static const String question5 = '5.	Which countries does Mkhosi operate in?';
  static const String answer5 =
      'Answer: The app is currently going to be used in South Africa, Tanzania, Lesotho, Swaziland, Kenya and Uganda. However, be on the lockout for new updates for services across the continent and the globe';
  //question 6
  static const String question6 = '6.	Where can I download the mobile app?';
  static const String answer6 =
      'Answer: The app is going to be available on all mobile app stores, free of charge';
  //question 7
  static const String question7 =
      '7.	What is the difference between signing up as a Service Provider and a General User/Client?';
  static const String answer7 =
      'Answer: Service Providers are the offering services and the General User is going to be the potential client. Features for both Users are different, and a General User cannot list their service.';
  //question 8
  static const String question8 = '8.	Do general users pay a subscription fee?';
  static const String answer8 =
      'Answer: No, the App is free for General Users. However, please note you will be charged for the services you buy from the service providers listed on Mkhosi';
  //question 9
  static const String question9 = '9.	Which languages does the app come in?';
  static const String answer9 =
      'Answer: The first version of the app will be available in the following languages: Swahili, Zulu, Sesotho, Venda, Xhosa, Tsonga in addition to English';
  //question 10
  static const String question10 =
      '10.	How do I contact support or account related inquiries?';
  static const String answer10 = 'Answer: support@mkhosi.com';
  //question 11
  static const String question11 =
      '11.	Do you get charged for the calls made inside the app?';
  static const String answer11 =
      'Answer: No, for General Users this is free, and for Service Providers this will be included in your subscription fees';
  //question 12
  static const String question12 =
      '12.	What are the Operating System requirements to download the app?';
  static const String answer12 = 'Answer:  iOS and Android';
  //question 13
  static const String question13 =
      '13.	How secure is my data on the Mkhosi App?';
  static const String answer13 =
      'Answer: Please refer to our Privacy Policy and also our Data Protection Guidelines';
  //question 14
  static const String question14 = '14.	What payment methods can be used?';
  static const String answer14 =
      'Answer: Service providers determine their payment methods. For in-app purchases, electronic payments are accepted i.e. credit/debit card or eft';

  //list of general questions
  static List<QuestionAnswerItem> listOfGeneral = [
    QuestionAnswerItem(
      question: question1,
      answer: answer1,
    ),
    QuestionAnswerItem(
      question: question2,
      answer: answer2,
    ),
    QuestionAnswerItem(
      question: question3,
      answer: answer3,
    ),
    QuestionAnswerItem(
      question: question4,
      answer: answer4,
    ),
    QuestionAnswerItem(
      question: question5,
      answer: answer5,
    ),
    QuestionAnswerItem(
      question: question6,
      answer: answer6,
    ),
    QuestionAnswerItem(
      question: question7,
      answer: answer7,
    ),
    QuestionAnswerItem(
      question: question8,
      answer: answer8,
    ),
    QuestionAnswerItem(
      question: question9,
      answer: answer9,
    ),
    QuestionAnswerItem(
      question: question10,
      answer: answer10,
    ),
    QuestionAnswerItem(
      question: question11,
      answer: answer11,
    ),
    QuestionAnswerItem(
      question: question12,
      answer: answer12,
    ),
    QuestionAnswerItem(
      question: question13,
      answer: answer13,
    ),
    QuestionAnswerItem(
      question: question14,
      answer: answer14,
    ),
  ];
  //buisness user
  //question 1
  static const String bquestion1 =
      '1.	How do I create an account on the Mkhosi app?';
  static const String banswer1 =
      'Answer: You will have to download the Mkhosi App from the App store and complete a sign up process which includes subscribing for a specific Mkhosi package. ';
  //question 2
  static const String bquestion2 =
      '2.	What is required for the signup process for Service Providers?';
  static const String banswer2 =
      'a.	Answer: All your business details, including location of your business, the type of service provided, your operating hours and availability and most important is a commitment to ethical business practices and allowing your clients to rate your services. Failure to provide correct information will result in Mkhosi disabling your account';
  //question 3
  static const String bquestion3 =
      '3.	Will I still have access to my appointments and other records if I change my phone? ';
  static const String banswer3 =
      'Answer: Yes. The data is kept on the App and all you need to do is reload the Mkhosi App and complete the security checks that identify you to be able to link you back to your Mkhosi account.';
//question 4
  static const String bquestion4 = '4.	Can I delete my Mkhosi account?';
  static const String banswer4 =
      'Answer: Yes you can. Please note that this does not mean your subscription is cancelled. To do that you will have to follow the process to cancel the subscription.';
  //question 5
  static const String bquestion5 =
      '5.	Can I register more than one service on the application?';
  static const String banswer5 = 'Answer: Yes, but not for this first release';
  //question 6
  static const String bquestion6 =
      '6.	Does Mkhosi integrate with all my other social media accounts?';
  static const String banswer6 = 'Answer: Yes';
  //list of buisness user questions
  static List<QuestionAnswerItem> listOfAccountSetup = [
    QuestionAnswerItem(
      question: bquestion1,
      answer: banswer1,
    ),
    QuestionAnswerItem(
      question: bquestion2,
      answer: banswer2,
    ),
    QuestionAnswerItem(
      question: bquestion3,
      answer: banswer3,
    ),
    QuestionAnswerItem(
      question: bquestion4,
      answer: banswer4,
    ),
    QuestionAnswerItem(
      question: bquestion5,
      answer: banswer5,
    ),
    QuestionAnswerItem(
      question: bquestion6,
      answer: banswer6,
    ),
  ];
  //calandar question
  //question 1
  static const String cquestion1 =
      '1.	Can I view all appointments currently set for the month?';
  static const String canswer1 =
      'Answer: Yes. You have access to different views which you can select in the settings.';
  //question 2
  static const String cquestion2 =
      '2.	Can I view just my working hours on the app?';
  static const String canswer2 =
      'Answer: You can customise your views on the app.';
  //question 3
  static const String cquestion3 =
      '3.	Can I add personal events or block off time on the calendar?';
  static const String canswer3 =
      'Answer: You can customise the setup of your calendar to suit your needs. This includes the views you prefer and the time slots that you want to make available. Our advice is to choose formats and times which can bring certainty to your clients and make it easier for new clients to book your services. ';
//question 4
  static const String cquestion4 =
      '4.	Can I sync Mkhosi with my Google/iOS calendar?';
  static const String canswer4 =
      'Answer: Yes you can. View our “Using Mkhosi Videos” on our YouTube channel for tutorials.';

  //list of general questions
  static List<QuestionAnswerItem> listOfCalandar = [
    QuestionAnswerItem(
      question: cquestion1,
      answer: canswer1,
    ),
    QuestionAnswerItem(
      question: cquestion2,
      answer: canswer2,
    ),
    QuestionAnswerItem(
      question: cquestion3,
      answer: canswer3,
    ),
    QuestionAnswerItem(
      question: cquestion4,
      answer: canswer4,
    ),
  ];
  //Appointment question
  //question 1
  static const String aquestion1 =
      '1.	Can I book two or more appointments in the same time slot?';
  static const String aanswer1 =
      'Answer: Not on this version of the App. Future versions will depending on research and user demand, have this feature.';
  //question 2
  static const String aquestion2 =
      '2.	Can I reschedule/postpone an appointment for another day?';
  static const String aanswer2 =
      "Answer: Yes you can. Clients will receive an automatic notification of the proposed change to the original appointment/booking." +
          "View the “Making appointments on Mkhosi” video on our YouTube channel";
  //question 3
  static const String aquestion3 =
      '3.	Can I add multiple people to an appointment?';
  static const String aanswer3 =
      'Answer: Not on this version of the App. Future versions will depending on research and user demand, have this feature';
//question 4
  static const String aquestion4 =
      '4.	Can I edit the start and time of an appointment';
  static const String aanswer4 =
      'Answer: On signing up, you will be required to set up our appointment schedule and timing. You will not be able to change an appointment to a different time interval without affecting all the appointments. ';
//question 5
  static const String aquestion5 =
      '5.	Can I learn more about the options available to me on my appointments?';
  static const String aanswer5 =
      'Answer: Yes you can. Mkhosi’s YouTube channel has tutorials on all aspects of setting up an using the App';

  //list of general questions
  static List<QuestionAnswerItem> listOfAppointment = [
    QuestionAnswerItem(
      question: aquestion1,
      answer: aanswer1,
    ),
    QuestionAnswerItem(
      question: aquestion2,
      answer: aanswer2,
    ),
    QuestionAnswerItem(
      question: aquestion3,
      answer: aanswer3,
    ),
    QuestionAnswerItem(
      question: aquestion4,
      answer: aanswer4,
    ),
    QuestionAnswerItem(
      question: aquestion5,
      answer: aanswer5,
    ),
  ];
  //reminders
  //question 1
  static const String rquestion1 = '1.	Can I customize my message template?';
  static const String ranswer1 =
      'Answer: Yes you can customise your message template to suite your requirements. Selecting the premium “Shine” Package allows you to have video messaging integrated.';
  //question 2
  static const String rquestion2 =
      '2.	Does the app have a reminder feature for my clients?';
  static const String ranswer2 =
      "Yes, Mkhosi has an automatic reminder feature for all appointments. An automatic notification will be sent to all your clients 24 hours before their appointment.";
  //question 3
  static const String rquestion3 =
      '3.	Can I change the language/date/time and format in my messages?';
  static const String ranswer3 =
      'Answer: yes you can. Mkhosi is currently available in 7 languages and multiple date and time formats. You can use any of the languages that are on the app. ';
//question 4
  static const String rquestion4 = '4.	Do I get charged extra for reminders?';
  static const String ranswer4 =
      'Answer: No. reminders are included in all the packages. Mkhosi does not have any hidden charges.';

  //list of general questions
  static List<QuestionAnswerItem> listOfReminders = [
    QuestionAnswerItem(
      question: rquestion1,
      answer: ranswer1,
    ),
    QuestionAnswerItem(
      question: rquestion2,
      answer: ranswer2,
    ),
    QuestionAnswerItem(
      question: rquestion3,
      answer: ranswer3,
    ),
    QuestionAnswerItem(
      question: rquestion4,
      answer: ranswer4,
    ),
  ];
  //Bookings
  //question 1
  static const String bbquestion1 =
      '1.	How does the appointment booking feature work?';
  static const String bbanswer1 =
      'Answer: Clients will choose a time slot that is available and make a provisional booking with you. You will receive a notification of the booking request which you have to accept before it is confirmed.';
  //question 2
  static const String bbquestion2 = '2.	Can I decline an appointment request?';
  static const String bbanswer2 =
      "Answer: You can although we do not advise this. Building trust between you and your clients is important to us at Mkhosi and we recommend that you invest time to ensure that you only open time slots that you can commit to. Exceptions and errors do occur.";
  //question 3
  static const String bbquestion3 =
      '3.	How many Hours should I have if I want to Cancel an appointment/ booking';
  static const String bbanswer3 =
      'Answer: If you need to cancel an appointment/ booking, you should cancel it as soon as possible. Preferably before 24 hours of your appointment/booking.';
//question 4
  static const String bbquestion4 =
      '4.	Can someone else make the Appointment or Booking for me?';
  static const String bbanswer4 =
      'Answer: Yes, provided they have a profile on the app';
//question 5
  static const String bbquestion5 =
      '5.	Does Mkhosi integrate with my Facebook/ Instagram’s book now button?';
  static const String bbanswer5 =
      'Answer: In order to protect your data, Mkhosi is not integrated. However Mkhosi will carry links to the service providers social media account.';
//question 6
  static const String bbquestion6 =
      '6.	What is the earliest time slot I can get and what is the latest time slot I can get?';
  static const String bbanswer6 =
      'Answer: The time slots can be found under the specific service you require. Each service provider has shared their availability and these may differ. Please look at the specific service provider you would like to book.';
//question 7
  static const String bbquestion7 = '7.	How long is a booking/appointment?';
  static const String bbanswer7 =
      'Answer: The time slots can be found under the specific service you require. Each service provider has shared their availability and these may differ. Please look at the specific service provider you would like to book.';

  //list of general questions
  static List<QuestionAnswerItem> listOfBookings = [
    QuestionAnswerItem(
      question: bbquestion1,
      answer: bbanswer1,
    ),
    QuestionAnswerItem(
      question: bbquestion2,
      answer: bbanswer2,
    ),
    QuestionAnswerItem(
      question: bbquestion3,
      answer: bbanswer3,
    ),
    QuestionAnswerItem(
      question: bbquestion4,
      answer: bbanswer4,
    ),
  ];
  //Clients
  //question 1
  static const String ccquestion1 =
      '1.	Can I import clients from my contact list?';
  static const String ccanswer1 =
      'Answer: Clients will choose a time slot that is available and make a provisional booking with you. You will receive a notification of the booking request which you have to accept before it is confirmed.';
  //question 2
  static const String ccquestion2 = '2.	Can I decline an appointment request?';
  static const String ccanswer2 =
      "Answer: You can although we do not advise this. Building trust between you and your clients is important to us at Mkhosi and we recommend that you invest time to ensure that you only open time slots that you can commit to. Exceptions and errors do occur.";

  //list of general questions
  static List<QuestionAnswerItem> listOfClients = [
    QuestionAnswerItem(
      question: ccquestion1,
      answer: ccanswer1,
    ),
    QuestionAnswerItem(
      question: ccquestion2,
      answer: ccanswer2,
    ),
  ];
  //Services
  //question 1
  static const String squestion1 = '1.	Can I list different services? ';
  static const String sanswer1 =
      'Answer: Yes. In your business description you can list all the services that you provide. Bookings can only be made on a per service basis so it is not possible to book one time slot for multiple services e.g. if you are a nail technician and a hairdresser, if a client books, they would book a slot for hair and another slot for nails. ';
  //question 2
  static const String squestion2 = '2.	Can I change the currency?';
  static const String sanswer2 =
      "Answer: Yes. The App will assign a default currency based on your location. You can change this as required. ";
//question 3
  static const String squestion3 =
      '3.	Is there additional guidance available on how to set up my profile';
  static const String sanswer3 =
      "Answer: Yes. Please watch the “Uploading Services onto Mkhosi” YouTube video for step by step tutorials.";

  //list of general questions
  static List<QuestionAnswerItem> listOfServices = [
    QuestionAnswerItem(
      question: squestion1,
      answer: sanswer1,
    ),
    QuestionAnswerItem(
      question: squestion2,
      answer: sanswer2,
    ),
    QuestionAnswerItem(
      question: squestion3,
      answer: sanswer3,
    ),
  ];
  //Reports
  //question 1
  static const String rrquestion1 =
      '1.	What type of Reports can I generate from Mkhosi?';
  static const String rranswer1 =
      'Answer: Yes. This will include financial reports and general client statistics.';
  //question 2
  static const String rrquestion2 = '2.	Do I pay for generating these Reports?';
  static const String rranswer2 =
      "Answer: No. This is included in your Premium subscription as one of the benefits";
//question 3
  static const String rrquestion3 =
      '3.	Can I see how much money I’ve made each day/week/month/year?';
  static const String rranswer3 =
      "Answer: Yes. Mkhosi has a variety of financial reports which you can generate as often as needed to manage your business. The reports can be customised.";
//question 4
  static const String rrquestion4 = '4.	Can I export my data for tax purposes?';
  static const String rranswer4 =
      "Answer: If you are registered for tax, please email support@mkhosi.com for one of our consultants to follow up with you.";

  //list of general questions
  static List<QuestionAnswerItem> listOfReports = [
    QuestionAnswerItem(
      question: rrquestion1,
      answer: rranswer1,
    ),
    QuestionAnswerItem(
      question: rrquestion2,
      answer: rranswer2,
    ),
    QuestionAnswerItem(
      question: rrquestion3,
      answer: rranswer3,
    ),
    QuestionAnswerItem(
      question: rrquestion4,
      answer: rranswer4,
    ),
  ];
  //Marketing questions
  //question 1
  static const String mquestion1 =
      '1.	Can I send a mass/bulk message to all my clients?';
  static const String manswer1 =
      'Answer: Yes you can send notifications through the Mkhosi app at no extra charge.';
  //question 2
  static const String mquestion2 = '2.	Can I send rebooking reminders?';
  static const String manswer2 =
      'Answer: You can customise messages and reminders for your clients. These include marketing related messages. ';
  //question 3
  static const String mquestion3 =
      '3.	How will using Mkhosi help me in my business?';
  static const String manswer3 =
      'Answer: Mkhosi is designed to streamline all your business processes and automate these as far as possible freeing you to focus on delivering a quality service to your clients. Mkhosi is a tool to support you grow your business and to thrive. The “Mkhosi Business Coaching” program is a stepped program to assist you practically with interventions that unlock the constraints to growing your business including strategies for you to implement to provide best of breed client services.';
//question 4
  static const String mquestion4 =
      '4. Will Mkhosi help me to attract new clients?';
  static const String manswer4 =
      'Answer: Yes Mkhosi will support you. Each of our 3 packages has at a minimum a basic listing which will allow clients to search for your business and services. On the premium “Shine” package, Mkhosi will build and maintain a webpage for you in addition to the basic listing. Mkhosi will be marketing the App to users globally which will increase the accessibility for your business to a larger client base. The more you use Mkhosi and your clients provide authentic feedback and ratings, this will increase the visibility of your business to new clients.';
  //question 5
  static const String mquestion5 =
      '5.	Are there hidden charges like commissions etc that Mkhosi charges?';
  static const String manswer5 =
      'Answer: No. Mkhosi has no hidden charges. Mkhosi will always disclose upfront the services that are included or excluded from the subscription fee.';
  //question 6
  static const String mquestion6 = '6.	Can I change my plan anytime?';
  static const String manswer6 =
      'Answer: Yes you can upgrade or downgrade your plan at any time through the self service portal on the App. Please be aware that the effective date of change may be later than the date on which you initiate the change due to timing. Please view our policy on changes here. ';
  //question 7
  static const String mquestion7 = '7.	Does Mkhosi integrate with my website?';
  static const String manswer7 =
      'Answer: Mkhosi can link to your website, but your clients will still need to download the app from the app stores in order for them to interact with you and book appointments.';
  //question 8
  static const String mquestion8 = '8.	Can Mkhosi help me with a website?';
  static const String manswer8 =
      'Answer: Yes Mkhosi can create and host a website for you if you have chosen the premium “Shine” package.';
  //question 9
  static const String mquestion9 = '9.	For how long will data be stored?';
  static const String manswer9 =
      'Answer: Mkhosi will not delete your data stored under your business profile, however in the event that you have run out of space this will be an additional cost to add more storage space';

  //list of general questions
  static List<QuestionAnswerItem> listOfMarketing = [
    QuestionAnswerItem(
      question: mquestion1,
      answer: manswer1,
    ),
    QuestionAnswerItem(
      question: mquestion2,
      answer: manswer2,
    ),
    QuestionAnswerItem(
      question: mquestion3,
      answer: manswer3,
    ),
    QuestionAnswerItem(
      question: mquestion4,
      answer: manswer4,
    ),
    QuestionAnswerItem(
      question: mquestion5,
      answer: manswer5,
    ),
    QuestionAnswerItem(
      question: mquestion6,
      answer: manswer6,
    ),
    QuestionAnswerItem(
      question: mquestion7,
      answer: manswer7,
    ),
    QuestionAnswerItem(
      question: mquestion8,
      answer: manswer8,
    ),
    QuestionAnswerItem(
      question: mquestion9,
      answer: manswer9,
    ),
  ];
  //Plans and billing
  //question 1
  static const String pquestion1 = '1.	Is a Mkhosi appointment free?';
  static const String panswer1 = 'Answer: Yes.';
  //question 2
  static const String pquestion2 =
      '2.	How do I upgrade my account to Premium and why should I upgrade?';
  static const String panswer2 =
      "Answer: You can change your subscription options directly on the App. Due to our billing cycle, changes may be effected maximum within 2 weeks of the requested change. ";
//question 3
  static const String pquestion3 = '3.	How am I being billed?';
  static const String panswer3 =
      "Answer: Subscriptions are billed monthly or annually. ";
//question 4
  static const String pquestion4 = '4.	What are the payment method options?';
  static const String panswer4 =
      "Answer: Subscriptions are paid using credit/debit cards or EFT.";

  //list of general questions
  static List<QuestionAnswerItem> listOfPlaning = [
    QuestionAnswerItem(
      question: pquestion1,
      answer: panswer1,
    ),
    QuestionAnswerItem(
      question: pquestion2,
      answer: panswer2,
    ),
    QuestionAnswerItem(
      question: pquestion3,
      answer: panswer3,
    ),
    QuestionAnswerItem(
      question: pquestion4,
      answer: panswer4,
    ),
  ];
  //Security
  //question 1
  static const String ssquestion1 =
      '1.	What happens if I lose my phone or buy a new device?';
  static const String ssanswer1 =
      'Answer: You will have to reinstall the app onto your new device. Once all security verifications are completed, your profile will be reinstated onto the new device. It is important to keep your email and security information updated on the App. ';
  //question 2
  static const String ssquestion2 = '2.	Is my client data safe on Mkhosi?';
  static const String ssanswer2 =
      "Yes. Only you will have access to your clients information. This will not be provided to any other service provider. Your clients will have access to the full Mkhosi catalogue of service providers.";

  //list of general questions
  static List<QuestionAnswerItem> listOfSecurity = [
    QuestionAnswerItem(
      question: ssquestion1,
      answer: ssanswer1,
    ),
    QuestionAnswerItem(
      question: ssquestion2,
      answer: ssanswer2,
    ),
  ];
  //General User clients
  //general questions
  //question 1
  static const String gquestion1 =
      '1.	Why should I only contact my preferred service provider through Mkhosi?';
  static const String ganswer1 =
      'Answer: By using Mkhosi as the platform through which you contact your preferred service provider, you support these business owners to establish trading records for their businesses which can be used to grow the business and to make it more sustainable. Using the platform also means that you never lose contact with your preferred service provider for as long as they and you have the app. No more tears from losing the contact numbers of your best service provider. ';
  //question 2
  static const String gquestion2 =
      '2.	Can I use the app to reach other service providers?';
  static const String ganswer2 =
      'Answer: Yes you can. With Mkhosi you can procure services to be delivered in a different geographical location from where you are. As an example, if you need a custom baked cake or cupcakes to be delivered in Cape Town whilst you are in Durban, you can find a baker in Cape Town, confirm themes, book and pay for the cake all via the app and receive notification once the cake is delivered. ';
  //question 3
  static const String gquestion3 = '3.	Can I recommend Mkhosi to other people?';
  static const String ganswer3 =
      'Answer: Definitely yes. The larger the Mkhosi community grows, the better we will be able to provide services to you and the more small businesses that we can support to grow and thrive. We at Mkhosi believe that there is a massive untapped market that will allow all service providers to grow, effectively growing the pie rather than trying to share a stagnant pie for an ever larger population.';
//question 4
  static const String gquestion4 =
      '4. How do I know if the service provider I am choosing is reliable?';
  static const String ganswer4 =
      'Answer: We rely on feedback from the users of the services in the Mkhosi community. Your feedback is vital to us being able to provide guidance to other users of services and also ensures that service providers put their best foot forward when rendering their services. Mkhosi also monitor adherence by all service providers to a code of ethical conduct. Should there be any complaints or bad reviews, Mkhosi will engage the relevant service provider to determine whether these are issues which Mkhosi can assist the service provider with through its Mkhosi Business Coaching program or other remedial measures. If all else fails, the relationship with the service provider will be terminated.';
  //question 5
  static const String gquestion5 =
      '5.	Is there a penalty if I don’t show up for an appointment?';
  static const String ganswer5 =
      'Answer: Each service provider will have different policies on cancellation. Mkhosi makes communicating with your service provider simple so if you cannot commit to an appointment, we recommend that you notify the service provider as early as possible.';
  //question 6
  static const String gquestion6 =
      '6. Can I reschedule/postpone an appointment for another day?';
  static const String ganswer6 =
      'Answer: Yes you can, provided that your service provider selected this as an option on signing up.';
  //question 7
  static const String gquestion7 =
      '7.	Are businesses listed on Mkhosi verified?';
  static const String ganswer7 = 'Answer: Yes, they are verified by Mkhosi.';
  //question 8
  static const String gquestion8 =
      '8.	How does Mkhosi ensure that the service providers give good customer services?';
  static const String ganswer8 =
      'Answer: Mkhosi relies on the feedback and ratings from the Mkhosi community to ensure that only service providers who meet the needs of their clients are on the app. ';
  //question 9
  static const String gquestion9 = '9. Is there 24/7 customer support?';
  static const String ganswer9 =
      'Answer: Yes, Mkhosi has a 24/7 customer support line and will resolve all queries within a 48 hour period.';
  //question 10
  static const String gquestion10 =
      '10. Can I be a Client to more than 1 Service Provider on the App?';
  static const String ganswer10 =
      'Answer: Yes you can be a client of as many service providers as you require. ';

  //list of general questions
  static List<QuestionAnswerItem> listOfGeneralUsers = [
    QuestionAnswerItem(
      question: gquestion1,
      answer: ganswer1,
    ),
    QuestionAnswerItem(
      question: gquestion2,
      answer: ganswer2,
    ),
    QuestionAnswerItem(
      question: gquestion3,
      answer: ganswer3,
    ),
    QuestionAnswerItem(
      question: gquestion4,
      answer: ganswer4,
    ),
    QuestionAnswerItem(
      question: gquestion5,
      answer: ganswer5,
    ),
    QuestionAnswerItem(
      question: gquestion6,
      answer: ganswer6,
    ),
    QuestionAnswerItem(
      question: gquestion7,
      answer: ganswer7,
    ),
    QuestionAnswerItem(
      question: gquestion8,
      answer: ganswer8,
    ),
    QuestionAnswerItem(
      question: gquestion9,
      answer: ganswer9,
    ),
    QuestionAnswerItem(
      question: gquestion10,
      answer: ganswer10,
    ),
  ];
}

class QuestionAnswerItem {
  String question;
  String answer;
  QuestionAnswerItem({
    @required this.question,
    @required this.answer,
  });
}
