import 'package:flutter/material.dart';
import '../models/duaa.dart';

/// Catégories de douas disponibles dans l'app.
/// Pour ajouter une catégorie : ajoute une entrée ici, puis ses douas
/// dans [duaaList] avec le même [categoryId].
const List<DuaaCategory> duaaCategories = [
  DuaaCategory(
    id: 'voyage',
    icon: Icons.flight_takeoff,
    names: {'fr': 'Voyage', 'en': 'Travel', 'de': 'Reise', 'ar': 'السفر'},
  ),
  DuaaCategory(
    id: 'maladie',
    icon: Icons.healing,
    names: {'fr': 'Maladie', 'en': 'Illness', 'de': 'Krankheit', 'ar': 'المرض'},
  ),
  DuaaCategory(
    id: 'repas',
    icon: Icons.restaurant,
    names: {'fr': 'Repas', 'en': 'Meals', 'de': 'Mahlzeiten', 'ar': 'الطعام'},
  ),
  DuaaCategory(
    id: 'sommeil',
    icon: Icons.bedtime,
    names: {'fr': 'Sommeil', 'en': 'Sleep', 'de': 'Schlaf', 'ar': 'النوم'},
  ),
  DuaaCategory(
    id: 'maison',
    icon: Icons.home,
    names: {'fr': 'Maison', 'en': 'Home', 'de': 'Zuhause', 'ar': 'المنزل'},
  ),
  DuaaCategory(
    id: 'difficulte',
    icon: Icons.self_improvement,
    names: {'fr': 'Difficulté & anxiété', 'en': 'Hardship & anxiety', 'de': 'Schwierigkeiten & Angst', 'ar': 'الكرب والقلق'},
  ),
  DuaaCategory(
    id: 'mosquee',
    icon: Icons.mosque,
    names: {'fr': 'Mosquée', 'en': 'Mosque', 'de': 'Moschee', 'ar': 'المسجد'},
  ),
  DuaaCategory(
    id: 'matin_soir',
    icon: Icons.wb_twilight,
    names: {'fr': 'Matin & soir', 'en': 'Morning & evening', 'de': 'Morgen & Abend', 'ar': 'أذكار الصباح والمساء'},
  ),
  DuaaCategory(
    id: 'protection',
    icon: Icons.shield_moon,
    names: {'fr': 'Protection', 'en': 'Protection', 'de': 'Schutz', 'ar': 'الحماية'},
  ),
  DuaaCategory(
    id: 'etude',
    icon: Icons.school,
    names: {'fr': 'Étude & savoir', 'en': 'Study & knowledge', 'de': 'Lernen & Wissen', 'ar': 'العلم'},
  ),
  DuaaCategory(
    id: 'mariage',
    icon: Icons.favorite,
    names: {'fr': 'Mariage', 'en': 'Marriage', 'de': 'Ehe', 'ar': 'الزواج'},
  ),
];

/// Liste des douas, groupées par [categoryId].
const List<Duaa> duaaList = [
  // --- Voyage ---
  Duaa(
    id: 'voyage_1',
    categoryId: 'voyage',
    arabic:
        'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ، وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ',
    transliteration:
        "Subhanal-ladhi sakhkhara lana hadha wa ma kunna lahu muqrinin, wa inna ila rabbina lamunqalibun.",
    titles: {
      'fr': 'En montant dans le véhicule',
      'en': 'When boarding a vehicle',
      'de': 'Beim Besteigen eines Fahrzeugs',
      'ar': 'عند الركوب',
    },
    translations: {
      'fr': "Gloire à Celui qui a mis ceci à notre service, nous n'aurions pu y parvenir par nous-mêmes. Et c'est vers notre Seigneur que nous retournerons.",
      'en': "Glory to Him who has subjected this to us, and we could never have accomplished it by ourselves. And indeed, to our Lord we will return.",
      'de': "Gepriesen sei Der, Der uns dies dienstbar gemacht hat, wir hätten es aus eigener Kraft nicht vermocht. Und zu unserem Herrn werden wir zurückkehren.",
    },
    source: 'Sourate Az-Zukhruf, 43:13-14',
  ),
  Duaa(
    id: 'voyage_2',
    categoryId: 'voyage',
    arabic:
        'اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرَّ وَالتَّقْوَى، وَمِنَ الْعَمَلِ مَا تَرْضَى',
    transliteration:
        "Allahumma inna nas'aluka fi safarina hadha al-birra wat-taqwa, wa minal-'amali ma tarda.",
    titles: {
      'fr': 'Douaa du voyageur',
      'en': "Traveler's supplication",
      'de': 'Bittgebet des Reisenden',
      'ar': 'دعاء المسافر',
    },
    translations: {
      'fr': "Ô Allah, nous Te demandons, dans ce voyage, la bonté et la piété, et les actes qui Te satisfont.",
      'en': "O Allah, we ask You on this journey for righteousness and piety, and for deeds that please You.",
      'de': "O Allah, wir bitten Dich auf dieser Reise um Rechtschaffenheit und Gottesfurcht, und um Taten, die Dir gefallen.",
    },
    source: 'Sahih Muslim',
  ),

  // --- Maladie ---
  Duaa(
    id: 'maladie_1',
    categoryId: 'maladie',
    arabic: 'أَسْأَلُ اللَّهَ الْعَظِيمَ رَبَّ الْعَرْشِ الْعَظِيمِ أَنْ يَشْفِيَكَ',
    transliteration: "As'alu Allahal-'Adhima Rabbal-'Arshil-'Adhimi an yashfiyak.",
    titles: {
      'fr': 'Douaa pour un malade',
      'en': 'Supplication for a sick person',
      'de': 'Bittgebet für einen Kranken',
      'ar': 'دعاء للمريض',
    },
    translations: {
      'fr': "Je demande à Allah, le Tout-Puissant, Seigneur du Trône immense, de te guérir.",
      'en': "I ask Allah, the Mighty, Lord of the Immense Throne, to heal you.",
      'de': "Ich bitte Allah, den Allmächtigen, Herrn des gewaltigen Throns, dich zu heilen.",
    },
    source: 'At-Tirmidhi',
  ),
  Duaa(
    id: 'maladie_2',
    categoryId: 'maladie',
    arabic:
        'اللَّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَأْسَ، اشْفِ أَنْتَ الشَّافِي، لَا شِفَاءَ إِلَّا شِفَاؤُكَ، شِفَاءً لَا يُغَادِرُ سَقَمًا',
    transliteration:
        "Allahumma Rabban-nas, adh-hibil-ba's, ishfi Antash-Shafi, la shifa'a illa shifa'uka, shifa'an la yughadiru saqama.",
    titles: {
      'fr': 'Douaa dite en visitant un malade',
      'en': 'Supplication when visiting the sick',
      'de': 'Bittgebet beim Besuch eines Kranken',
      'ar': 'دعاء عيادة المريض',
    },
    translations: {
      'fr': "Ô Allah, Seigneur des hommes, dissipe le mal, guéris, c'est Toi qui guéris. Il n'y a de guérison que la Tienne, une guérison qui ne laisse aucune maladie.",
      'en': "O Allah, Lord of mankind, remove the affliction, heal, You are the Healer, there is no healing but Yours, a healing that leaves no illness behind.",
      'de': "O Allah, Herr der Menschen, nimm das Leid, heile, Du bist der Heiler, es gibt keine Heilung außer Deiner, eine Heilung, die keine Krankheit zurücklässt.",
    },
    source: 'Sahih Al-Boukhari',
  ),

  // --- Repas ---
  Duaa(
    id: 'repas_1',
    categoryId: 'repas',
    arabic: 'بِسْمِ اللَّهِ',
    transliteration: 'Bismillah.',
    titles: {
      'fr': 'Avant de manger',
      'en': 'Before eating',
      'de': 'Vor dem Essen',
      'ar': 'قبل الطعام',
    },
    translations: {
      'fr': 'Au nom d\'Allah.',
      'en': 'In the name of Allah.',
      'de': 'Im Namen Allahs.',
    },
    source: 'Sahih Al-Boukhari',
  ),
  Duaa(
    id: 'repas_2',
    categoryId: 'repas',
    arabic:
        'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنِي هَذَا، وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
    transliteration:
        "Alhamdu lillahil-ladhi at'amani hadha, wa razaqanihi min ghayri hawlin minni wa la quwwah.",
    titles: {
      'fr': 'Après avoir mangé',
      'en': 'After eating',
      'de': 'Nach dem Essen',
      'ar': 'بعد الطعام',
    },
    translations: {
      'fr': "Louange à Allah qui m'a nourri de ceci et me l'a accordé sans force ni pouvoir de ma part.",
      'en': "Praise be to Allah who fed me this and provided it for me without any power or strength on my part.",
      'de': "Gepriesen sei Allah, der mich damit ernährt und es mir gewährt hat, ohne meine Kraft oder Macht.",
    },
    source: 'Abu Dawud, At-Tirmidhi',
  ),

  // --- Sommeil ---
  Duaa(
    id: 'sommeil_1',
    categoryId: 'sommeil',
    arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
    transliteration: 'Bismika Allahumma amutu wa ahya.',
    titles: {
      'fr': 'Avant de dormir',
      'en': 'Before sleeping',
      'de': 'Vor dem Schlafen',
      'ar': 'عند النوم',
    },
    translations: {
      'fr': 'En Ton nom, ô Allah, je meurs et je vis.',
      'en': 'In Your name, O Allah, I die and I live.',
      'de': 'In Deinem Namen, o Allah, sterbe und lebe ich.',
    },
    source: 'Sahih Al-Boukhari',
  ),
  Duaa(
    id: 'sommeil_2',
    categoryId: 'sommeil',
    arabic:
        'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
    transliteration: "Alhamdu lillahil-ladhi ahyana ba'da ma amatana wa ilayhin-nushur.",
    titles: {
      'fr': 'Au réveil',
      'en': 'Upon waking up',
      'de': 'Beim Aufwachen',
      'ar': 'عند الاستيقاظ',
    },
    translations: {
      'fr': "Louange à Allah qui nous a redonné la vie après nous avoir fait mourir, et c'est vers Lui qu'est la résurrection.",
      'en': "Praise be to Allah who gave us life after having caused us to die, and unto Him is the resurrection.",
      'de': "Gepriesen sei Allah, der uns nach unserem Tod wieder zum Leben erweckt hat, und zu Ihm ist die Auferstehung.",
    },
    source: 'Sahih Al-Boukhari',
  ),

  // --- Maison ---
  Duaa(
    id: 'maison_1',
    categoryId: 'maison',
    arabic:
        'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
    transliteration: "Bismillahi, tawakkaltu 'alallah, wa la hawla wa la quwwata illa billah.",
    titles: {
      'fr': 'En sortant de la maison',
      'en': 'Leaving home',
      'de': 'Beim Verlassen des Hauses',
      'ar': 'الخروج من المنزل',
    },
    translations: {
      'fr': "Au nom d'Allah, je place ma confiance en Allah, il n'y a de force ni de puissance qu'en Allah.",
      'en': "In the name of Allah, I place my trust in Allah, there is no power nor strength except with Allah.",
      'de': "Im Namen Allahs, ich vertraue auf Allah, es gibt keine Kraft noch Macht außer bei Allah.",
    },
    source: 'Abu Dawud, At-Tirmidhi',
  ),
  Duaa(
    id: 'maison_2',
    categoryId: 'maison',
    arabic:
        'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلِجِ وَخَيْرَ الْمَخْرَجِ، بِسْمِ اللَّهِ وَلَجْنَا وَبِسْمِ اللَّهِ خَرَجْنَا وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا',
    transliteration:
        "Allahumma inni as'aluka khayral-mawliji wa khayral-makhraji, bismillahi walajna wa bismillahi kharajna wa 'alallahi rabbina tawakkalna.",
    titles: {
      'fr': 'En entrant dans la maison',
      'en': 'Entering home',
      'de': 'Beim Betreten des Hauses',
      'ar': 'الدخول إلى المنزل',
    },
    translations: {
      'fr': "Ô Allah, je Te demande le meilleur en entrant et le meilleur en sortant. Au nom d'Allah nous entrons, au nom d'Allah nous sortons, et en Allah, notre Seigneur, nous plaçons notre confiance.",
      'en': "O Allah, I ask You for the best of entering and the best of leaving. In the name of Allah we enter, in the name of Allah we leave, and upon Allah, our Lord, we rely.",
      'de': "O Allah, ich bitte Dich um das Beste beim Eintreten und das Beste beim Verlassen. Im Namen Allahs treten wir ein, im Namen Allahs verlassen wir, und auf Allah, unseren Herrn, vertrauen wir.",
    },
    source: 'Abu Dawud',
  ),

  // --- Difficulté / anxiété ---
  Duaa(
    id: 'difficulte_1',
    categoryId: 'difficulte',
    arabic: 'لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
    transliteration: "La ilaha illa anta subhanaka inni kuntu minadh-dhalimin.",
    titles: {
      'fr': "Douaa du prophète Younous (Jonas)",
      'en': "Supplication of Prophet Yunus (Jonah)",
      'de': "Bittgebet des Propheten Yunus (Jona)",
      'ar': 'دعاء يونس عليه السلام',
    },
    translations: {
      'fr': "Il n'y a de divinité que Toi ! Gloire à Toi ! J'ai été parmi les injustes.",
      'en': "There is no god but You, glory be to You, I have been among the wrongdoers.",
      'de': "Es gibt keinen Gott außer Dir, gepriesen seist Du, ich war unter den Ungerechten.",
    },
    source: 'Sourate Al-Anbiya, 21:87',
  ),
  Duaa(
    id: 'difficulte_2',
    categoryId: 'difficulte',
    arabic:
        'اللَّهُمَّ رَحْمَتَكَ أَرْجُو فَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ، وَأَصْلِحْ لِي شَأْنِي كُلَّهُ، لَا إِلَهَ إِلَّا أَنْتَ',
    transliteration:
        "Allahumma rahmataka arju fala takilni ila nafsi tarfata 'ayn, wa aslih li sha'ni kullah, la ilaha illa anta.",
    titles: {
      'fr': "Douaa en cas de détresse",
      'en': "Supplication in times of distress",
      'de': "Bittgebet in Notlagen",
      'ar': 'دعاء الكرب',
    },
    translations: {
      'fr': "Ô Allah, j'espère en Ta miséricorde, ne m'abandonne pas à moi-même ne serait-ce qu'un clin d'œil, et arrange toute mon affaire. Il n'y a de divinité que Toi.",
      'en': "O Allah, I hope for Your mercy, do not leave me to myself even for the blink of an eye, and set right all my affairs. There is no god but You.",
      'de': "O Allah, ich hoffe auf Deine Barmherzigkeit, überlasse mich nicht mir selbst, auch nicht für einen Augenblick, und ordne all meine Angelegenheiten. Es gibt keinen Gott außer Dir.",
    },
    source: 'Abu Dawud',
  ),

  // --- Mosquée ---
  Duaa(
    id: 'mosquee_1',
    categoryId: 'mosquee',
    arabic: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
    transliteration: 'Allahumma iftah li abwaba rahmatik.',
    titles: {
      'fr': 'En entrant à la mosquée',
      'en': 'Entering the mosque',
      'de': 'Beim Betreten der Moschee',
      'ar': 'دخول المسجد',
    },
    translations: {
      'fr': "Ô Allah, ouvre-moi les portes de Ta miséricorde.",
      'en': "O Allah, open the doors of Your mercy for me.",
      'de': "O Allah, öffne mir die Tore Deiner Barmherzigkeit.",
    },
    source: 'Sahih Muslim',
  ),
  Duaa(
    id: 'mosquee_2',
    categoryId: 'mosquee',
    arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ',
    transliteration: 'Allahumma inni as\'aluka min fadlik.',
    titles: {
      'fr': 'En sortant de la mosquée',
      'en': 'Leaving the mosque',
      'de': 'Beim Verlassen der Moschee',
      'ar': 'الخروج من المسجد',
    },
    translations: {
      'fr': "Ô Allah, je Te demande de Ta grâce.",
      'en': "O Allah, I ask You from Your bounty.",
      'de': "O Allah, ich bitte Dich um Deine Gunst.",
    },
    source: 'Sahih Muslim',
  ),

  // --- Matin & soir ---
  Duaa(
    id: 'matin_soir_1',
    categoryId: 'matin_soir',
    arabic:
        'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
    transliteration:
        "Allahumma anta Rabbi la ilaha illa anta, khalaqtani wa ana 'abduka, wa ana 'ala 'ahdika wa wa'dika mastata't. Abu'u laka bini'matika 'alayya, wa abu'u bidhanbi, faghfir li, fa innahu la yaghfirudh-dhunuba illa ant.",
    titles: {
      'fr': "Maître de la demande de pardon (Sayyid al-Istighfar)",
      'en': "Master supplication for forgiveness",
      'de': "Herr der Bitte um Vergebung",
      'ar': 'سيد الاستغفار',
    },
    translations: {
      'fr': "Ô Allah, Tu es mon Seigneur, il n'y a de divinité que Toi. Tu m'as créé et je suis Ton serviteur ; je m'efforce de tenir mon engagement envers Toi autant que possible. Je reconnais envers Toi Ton bienfait sur moi, et je reconnais mon péché : pardonne-moi, car nul ne pardonne les péchés sauf Toi.",
      'en': "O Allah, You are my Lord, there is no god but You. You created me and I am Your servant, and I am upon Your covenant as much as I am able. I acknowledge Your favor upon me and I acknowledge my sin, so forgive me, for none forgives sins but You.",
      'de': "O Allah, Du bist mein Herr, es gibt keinen Gott außer Dir. Du hast mich erschaffen und ich bin Dein Diener, ich halte an Deinem Bund fest, so gut ich kann. Ich erkenne Deine Gunst mir gegenüber an und erkenne meine Sünde an, so vergib mir, denn niemand vergibt Sünden außer Dir.",
    },
    source: 'Sahih Al-Boukhari',
  ),
  Duaa(
    id: 'matin_soir_2',
    categoryId: 'matin_soir',
    arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ',
    transliteration: "Asbahna wa asbahal-mulku lillah, walhamdu lillah.",
    titles: {
      'fr': 'Dhikr du matin',
      'en': 'Morning remembrance',
      'de': 'Morgengedenken',
      'ar': 'ذكر الصباح',
    },
    translations: {
      'fr': "Nous voici au matin, et la royauté appartient à Allah, louange à Allah.",
      'en': "We have reached the morning, and with it all dominion belongs to Allah, praise be to Allah.",
      'de': "Wir haben den Morgen erreicht, und die Herrschaft gehört Allah, Lob sei Allah.",
    },
    source: 'Sahih Muslim',
  ),

  // --- Protection ---
  Duaa(
    id: 'protection_1',
    categoryId: 'protection',
    arabic:
        'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    transliteration:
        "Bismillahil-ladhi la yadurru ma'as-mihi shay'un fil-ardi wa la fis-sama'i, wa Huwas-Sami'ul-'Alim.",
    titles: {
      'fr': 'Protection quotidienne (matin/soir)',
      'en': 'Daily protection (morning/evening)',
      'de': 'Täglicher Schutz (morgens/abends)',
      'ar': 'دعاء الحفظ اليومي',
    },
    translations: {
      'fr': "Au nom d'Allah, avec le nom duquel rien ne peut nuire ni sur terre ni au ciel, et Il est Celui qui entend, qui sait tout.",
      'en': "In the name of Allah, with whose name nothing can cause harm on earth nor in the heavens, and He is the All-Hearing, the All-Knowing.",
      'de': "Im Namen Allahs, mit dessen Namen nichts auf der Erde noch im Himmel schaden kann, und Er ist der Allhörende, der Allwissende.",
    },
    source: 'Abu Dawud, At-Tirmidhi',
  ),
  Duaa(
    id: 'protection_2',
    categoryId: 'protection',
    arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
    transliteration: "A'udhu bikalimatillahit-tammati min sharri ma khalaq.",
    titles: {
      'fr': 'Contre le mal des créatures',
      'en': 'Against the evil of creation',
      'de': 'Gegen das Übel der Schöpfung',
      'ar': 'التعوذ من شر المخلوقات',
    },
    translations: {
      'fr': "Je cherche refuge dans les paroles parfaites d'Allah contre le mal de ce qu'Il a créé.",
      'en': "I seek refuge in the perfect words of Allah from the evil of what He has created.",
      'de': "Ich suche Zuflucht in den vollkommenen Worten Allahs vor dem Übel dessen, was Er erschaffen hat.",
    },
    source: 'Sahih Muslim',
  ),

  // --- Étude & savoir ---
  Duaa(
    id: 'etude_1',
    categoryId: 'etude',
    arabic: 'رَبِّ زِدْنِي عِلْمًا',
    transliteration: "Rabbi zidni 'ilma.",
    titles: {
      'fr': 'Avant d\'étudier',
      'en': 'Before studying',
      'de': 'Vor dem Lernen',
      'ar': 'قبل الدراسة',
    },
    translations: {
      'fr': "Seigneur, accroît mes connaissances.",
      'en': "My Lord, increase me in knowledge.",
      'de': "Mein Herr, mehre mein Wissen.",
    },
    source: 'Sourate Ta-Ha, 20:114',
  ),
  Duaa(
    id: 'etude_2',
    categoryId: 'etude',
    arabic:
        'اللَّهُمَّ انْفَعْنِي بِمَا عَلَّمْتَنِي وَعَلِّمْنِي مَا يَنْفَعُنِي وَزِدْنِي عِلْمًا',
    transliteration:
        "Allahummanfa'ni bima 'allamtani wa 'allimni ma yanfa'uni wa zidni 'ilma.",
    titles: {
      'fr': 'Pour un savoir utile',
      'en': 'For beneficial knowledge',
      'de': 'Für nützliches Wissen',
      'ar': 'دعاء العلم النافع',
    },
    translations: {
      'fr': "Ô Allah, fais-moi profiter de ce que Tu m'as enseigné, enseigne-moi ce qui m'est utile et augmente mes connaissances.",
      'en': "O Allah, benefit me with what You have taught me, teach me what will benefit me, and increase me in knowledge.",
      'de': "O Allah, lass mich von dem profitieren, was Du mich gelehrt hast, lehre mich, was mir nützt, und mehre mein Wissen.",
    },
    source: 'At-Tirmidhi, Ibn Majah',
  ),

  // --- Mariage ---
  Duaa(
    id: 'mariage_1',
    categoryId: 'mariage',
    arabic: 'بَارَكَ اللَّهُ لَكَ وَبَارَكَ عَلَيْكَ وَجَمَعَ بَيْنَكُمَا فِي خَيْرٍ',
    transliteration: "Barakallahu laka, wa baraka 'alayka, wa jama'a baynakuma fi khayr.",
    titles: {
      'fr': 'Félicitations aux mariés',
      'en': 'Congratulating the newlyweds',
      'de': 'Glückwunsch an das Brautpaar',
      'ar': 'تهنئة العروسين',
    },
    translations: {
      'fr': "Qu'Allah te bénisse, répande Sa bénédiction sur toi et vous unisse tous deux dans le bien.",
      'en': "May Allah bless you, and shower His blessings upon you, and join you together in goodness.",
      'de': "Möge Allah dich segnen, Seinen Segen über dich ausbreiten und euch beide im Guten vereinen.",
    },
    source: 'Abu Dawud, At-Tirmidhi',
  ),
  Duaa(
    id: 'mariage_2',
    categoryId: 'mariage',
    arabic:
        'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَهَا وَخَيْرَ مَا جَبَلْتَهَا عَلَيْهِ، وَأَعُوذُ بِكَ مِنْ شَرِّهَا وَشَرِّ مَا جَبَلْتَهَا عَلَيْهِ',
    transliteration:
        "Allahumma inni as'aluka khayraha wa khayra ma jabaltaha 'alayh, wa a'udhu bika min sharriha wa sharri ma jabaltaha 'alayh.",
    titles: {
      'fr': 'Douaa du mari le soir des noces',
      'en': "Husband's supplication on the wedding night",
      'de': 'Bittgebet des Ehemanns in der Hochzeitsnacht',
      'ar': 'دعاء ليلة الزفاف',
    },
    translations: {
      'fr': "Ô Allah, je Te demande son bien et le bien de ce sur quoi Tu l'as façonnée, et je cherche refuge auprès de Toi contre son mal et le mal de ce sur quoi Tu l'as façonnée.",
      'en': "O Allah, I ask You for her good and the good of that which You have disposed her to, and I seek refuge in You from her evil and the evil of that which You have disposed her to.",
      'de': "O Allah, ich bitte Dich um ihr Gutes und das Gute dessen, wozu Du sie veranlagt hast, und ich suche Zuflucht bei Dir vor ihrem Übel und dem Übel dessen, wozu Du sie veranlagt hast.",
    },
    source: 'Abu Dawud',
  ),
];

List<Duaa> duaasForCategory(String categoryId) =>
    duaaList.where((d) => d.categoryId == categoryId).toList();
