import 'package:pregmaa/model/article_model.dart';
import 'package:pregmaa/model/article_section_model.dart';

List<Article> pregnancyArticles = [
  /// ARTICLE 1
  Article(
    id: "1",

    titleEn: "COVID-19 Vaccination During Pregnancy",
    titleHi: "गर्भावस्था के दौरान COVID-19 टीकाकरण",
    titleMr: "गर्भधारणादरम्यान COVID-19 लसीकरण",

    introEn:
        "COVID-19 vaccination is recommended for pregnant women to protect both mother and baby from severe illness.",
    introHi:
        "गर्भवती महिलाओं को COVID-19 टीकाकरण की सलाह दी जाती है ताकि माँ और बच्चे को गंभीर बीमारी से बचाया जा सके।",
    introMr:
        "गर्भवती महिलांना COVID-19 लस घेण्याची शिफारस केली जाते जेणेकरून आई आणि बाळाचे संरक्षण होईल.",

    source: "CDC & WHO Guidelines (2023-2025)",

    sections: [
      ArticleSection(
        headingEn: "Benefits of Vaccination",
        headingHi: "टीकाकरण के लाभ",
        headingMr: "लसीकरणाचे फायदे",

        pointsEn: [
          "Reduces risk of severe COVID-19 illness",
          "Helps protect newborn baby",
          "Reduces hospitalization risk",
        ],

        pointsHi: [
          "गंभीर COVID-19 बीमारी का जोखिम कम करता है",
          "नवजात शिशु की सुरक्षा में मदद करता है",
          "अस्पताल में भर्ती होने का जोखिम कम करता है",
        ],

        pointsMr: [
          "गंभीर COVID-19 आजाराचा धोका कमी करतो",
          "नवजात बाळाचे संरक्षण करण्यात मदत करते",
          "रुग्णालयात दाखल होण्याचा धोका कमी करतो",
        ],
      ),

      ArticleSection(
        headingEn: "When to Take Vaccine",
        headingHi: "टीका कब लेना चाहिए",
        headingMr: "लस कधी घ्यावी",

        pointsEn: [
          "Vaccination can be taken during any trimester",
          "Consult doctor before vaccination",
        ],

        pointsHi: [
          "टीका किसी भी तिमाही में लिया जा सकता है",
          "टीका लेने से पहले डॉक्टर से सलाह लें",
        ],

        pointsMr: [
          "लस कोणत्याही तिमाहीत घेतली जाऊ शकते",
          "लस घेण्यापूर्वी डॉक्टरांचा सल्ला घ्या",
        ],
      ),
    ],
  ),

  /// ARTICLE 2
  Article(
    id: "2",

    titleEn: "Flu Vaccine During Pregnancy",
    titleHi: "गर्भावस्था में फ्लू टीका",
    titleMr: "गर्भधारणादरम्यान फ्लू लस",

    introEn:
        "Flu vaccination helps protect pregnant women from serious flu complications.",
    introHi:
        "फ्लू टीकाकरण गर्भवती महिलाओं को गंभीर फ्लू से बचाने में मदद करता है।",
    introMr: "फ्लू लस गर्भवती महिलांना गंभीर फ्लूपासून संरक्षण देते.",

    source: "CDC Flu Guidelines (2024)",

    sections: [
      ArticleSection(
        headingEn: "Why Flu Vaccine is Important",
        headingHi: "फ्लू टीका क्यों जरूरी है",
        headingMr: "फ्लू लस का महत्त्व",

        pointsEn: [
          "Pregnant women have higher risk of flu complications",
          "Flu can cause early delivery risk",
          "Protects baby after birth",
        ],

        pointsHi: [
          "गर्भवती महिलाओं में फ्लू का खतरा अधिक होता है",
          "फ्लू समय से पहले प्रसव का कारण बन सकता है",
          "जन्म के बाद बच्चे की सुरक्षा करता है",
        ],

        pointsMr: [
          "गर्भवती महिलांमध्ये फ्लूचा धोका जास्त असतो",
          "फ्लूमुळे अकाली प्रसूती होऊ शकते",
          "जन्मानंतर बाळाचे संरक्षण करते",
        ],
      ),
    ],
  ),

  /// ARTICLE 3
  Article(
    id: "3",

    titleEn: "Mental Health During Pregnancy",
    titleHi: "गर्भावस्था के दौरान मानसिक स्वास्थ्य",
    titleMr: "गर्भधारणादरम्यान मानसिक आरोग्य",

    introEn:
        "Mental health is an important part of pregnancy care and should not be ignored.",
    introHi: "मानसिक स्वास्थ्य गर्भावस्था देखभाल का एक महत्वपूर्ण हिस्सा है।",
    introMr: "मानसिक आरोग्य हे गर्भधारणेचा महत्त्वाचा भाग आहे.",

    source: "WHO Mental Health Guidelines (2022-2024)",

    sections: [
      ArticleSection(
        headingEn: "Common Mental Health Issues",
        headingHi: "सामान्य मानसिक समस्याएं",
        headingMr: "सामान्य मानसिक समस्या",

        pointsEn: ["Stress and anxiety", "Mood changes", "Feeling overwhelmed"],

        pointsHi: ["तनाव और चिंता", "मूड में बदलाव", "अधिक तनाव महसूस करना"],

        pointsMr: ["तणाव आणि चिंता", "मूड बदल", "अतिताण जाणवणे"],
      ),

      ArticleSection(
        headingEn: "How to Stay Mentally Healthy",
        headingHi: "मानसिक रूप से स्वस्थ कैसे रहें",
        headingMr: "मानसिक आरोग्य कसे राखावे",

        pointsEn: [
          "Talk to family or friends",
          "Practice relaxation techniques",
          "Seek professional help if needed",
        ],

        pointsHi: [
          "परिवार या दोस्तों से बात करें",
          "आराम करने की तकनीक अपनाएं",
          "जरूरत हो तो डॉक्टर से मिलें",
        ],

        pointsMr: [
          "कुटुंब किंवा मित्रांशी बोला",
          "आराम तंत्रांचा वापर करा",
          "गरज असल्यास डॉक्टरांचा सल्ला घ्या",
        ],
      ),
    ],
  ),

  /// ARTICLE 4
  Article(
    id: "4",

    titleEn: "Gestational Diabetes Screening",
    titleHi: "गर्भावधि मधुमेह जांच",
    titleMr: "गर्भधारणादरम्यान मधुमेह तपासणी",

    introEn:
        "Gestational diabetes is a common condition that can occur during pregnancy.",
    introHi:
        "गर्भावधि मधुमेह गर्भावस्था के दौरान होने वाली एक सामान्य समस्या है।",
    introMr: "गर्भधारणेदरम्यान होणारा मधुमेह ही एक सामान्य समस्या आहे.",

    source: "ACOG Diabetes Guidelines (2023)",

    sections: [
      ArticleSection(
        headingEn: "Risk Factors",
        headingHi: "जोखिम कारक",
        headingMr: "जोखीम घटक",

        pointsEn: [
          "Overweight before pregnancy",
          "Family history of diabetes",
          "Previous gestational diabetes",
        ],

        pointsHi: [
          "गर्भावस्था से पहले अधिक वजन",
          "परिवार में मधुमेह का इतिहास",
          "पहले गर्भावधि मधुमेह होना",
        ],

        pointsMr: [
          "गर्भधारणेपूर्वी जास्त वजन",
          "कुटुंबात मधुमेहाचा इतिहास",
          "पूर्वी मधुमेह असणे",
        ],
      ),
    ],
  ),

  /// ARTICLE 5
  Article(
    id: "5",

    titleEn: "Best Sleeping Position During Pregnancy",
    titleHi: "गर्भावस्था में सही सोने की स्थिति",
    titleMr: "गर्भधारणादरम्यान योग्य झोपेची स्थिती",

    introEn:
        "Sleeping on the left side is generally recommended during pregnancy.",
    introHi: "गर्भावस्था में बाईं ओर सोना सबसे अच्छा माना जाता है।",
    introMr: "गर्भधारणेदरम्यान डाव्या बाजूला झोपणे योग्य मानले जाते.",

    source: "NHS Pregnancy Care Guide (2023)",

    sections: [
      ArticleSection(
        headingEn: "Why Left Side is Recommended",
        headingHi: "बाईं ओर सोना क्यों बेहतर है",
        headingMr: "डाव्या बाजूला झोपणे का चांगले",

        pointsEn: [
          "Improves blood flow to baby",
          "Supports kidney function",
          "Reduces swelling in legs",
        ],

        pointsHi: [
          "बच्चे तक रक्त प्रवाह बढ़ाता है",
          "किडनी को बेहतर काम करने में मदद करता है",
          "पैरों की सूजन कम करता है",
        ],

        pointsMr: [
          "बाळापर्यंत रक्तप्रवाह सुधारतो",
          "मूत्रपिंड कार्यास मदत होते",
          "पायांची सूज कमी होते",
        ],
      ),
    ],
  ),
];
