import '../models/watch_model.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';

class StaticData {
  static final List<String> brands = [
    'All Brands',
    'Rolex',
    'Patek Philippe',
    'Audemars Piguet',
    'Omega',
    'Cartier',
    'IWC',
    'Jaeger-LeCoultre',
    'Vacheron Constantin',
    'Breitling',
    'Tag Heuer',
  ];

  static final List<String> conditions = [
    'All Conditions',
    'New',
    'Excellent',
    'Very Good',
    'Good',
    'Fair',
  ];

  static final List<String> priceRanges = [
    'All Prices',
    'Under \$5,000',
    '\$5,000 - \$10,000',
    '\$10,000 - \$25,000',
    '\$25,000 - \$50,000',
    '\$50,000 - \$100,000',
    'Over \$100,000',
  ];

  static final List<String> years = [
    'All Years',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2015-2019',
    '2010-2014',
    'Before 2010',
  ];

  static final UserModel currentUser = UserModel(
    id: 'user_001',
    name: 'Alexander Chen',
    email: 'alexander.chen@email.com',
    profileImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    createdAt: DateTime(2023, 1, 15),
  );

  static final List<WatchModel> watches = [
    WatchModel(
      id: 'watch_001',
      brand: 'Rolex',
      model: 'Submariner Date',
      year: 2023,
      condition: 'New',
      price: 14500,
      description: 'The Rolex Submariner Date in Oystersteel with a black Cerachrom bezel insert and a black dial. This iconic diving watch features a unidirectional rotatable bezel, Chromalight display, and is water-resistant to 300 meters. Complete with box and papers.',
      images: [
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800',
        'https://images.unsplash.com/photo-1548171915-e79a380a2a4b?w=800',
      ],
      sellerId: 'seller_001',
      sellerName: 'Premium Timepieces',
      sellerImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    WatchModel(
      id: 'watch_002',
      brand: 'Patek Philippe',
      model: 'Nautilus 5711',
      year: 2021,
      condition: 'Excellent',
      price: 125000,
      description: 'The legendary Patek Philippe Nautilus 5711/1A in stainless steel with the iconic blue dial. This highly sought-after timepiece features the distinctive porthole design by Gerald Genta. Complete set with all original documentation.',
      images: [
        'https://images.unsplash.com/photo-1614164185128-e4ec99c436d7?w=800',
        'https://images.unsplash.com/photo-1612817159949-195b6eb9e31a?w=800',
        'https://images.unsplash.com/photo-1618220179428-22790b461013?w=800',
      ],
      sellerId: 'seller_002',
      sellerName: 'Elite Watch Gallery',
      sellerImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      isFavorite: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    WatchModel(
      id: 'watch_003',
      brand: 'Audemars Piguet',
      model: 'Royal Oak',
      year: 2022,
      condition: 'Excellent',
      price: 45000,
      description: 'Audemars Piguet Royal Oak Selfwinding 41mm in stainless steel. Features the iconic "Grande Tapisserie" dial pattern and integrated bracelet. This masterpiece represents the pinnacle of luxury sports watch design.',
      images: [
        'https://images.unsplash.com/photo-1594534475808-b18fc33b045e?w=800',
        'https://images.unsplash.com/photo-1619134778706-7015533a6150?w=800',
        'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800',
      ],
      sellerId: 'seller_003',
      sellerName: 'Horological Masters',
      sellerImage: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    WatchModel(
      id: 'watch_004',
      brand: 'Omega',
      model: 'Speedmaster Moonwatch',
      year: 2023,
      condition: 'New',
      price: 7200,
      description: 'The Omega Speedmaster Professional Moonwatch with the legendary calibre 1861 manual-winding movement. This is the watch that went to the moon, featuring a black dial with luminous hands and hour markers.',
      images: [
        'https://images.unsplash.com/photo-1622434641406-a158123450f9?w=800',
        'https://images.unsplash.com/photo-1609587312208-cea54be969e7?w=800',
        'https://images.unsplash.com/photo-1585123334904-845d60e97b29?w=800',
      ],
      sellerId: 'seller_001',
      sellerName: 'Premium Timepieces',
      sellerImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    WatchModel(
      id: 'watch_005',
      brand: 'Cartier',
      model: 'Santos de Cartier',
      year: 2022,
      condition: 'Very Good',
      price: 8500,
      description: 'The Santos de Cartier in medium size, featuring the iconic square case with exposed screws. This historic design, created in 1904 for aviator Alberto Santos-Dumont, combines elegance with a bold aesthetic.',
      images: [
        'https://images.unsplash.com/photo-1639037687665-4e82d8dbf0b3?w=800',
        'https://images.unsplash.com/photo-1612817159949-195b6eb9e31a?w=800',
        'https://images.unsplash.com/photo-1618220179428-22790b461013?w=800',
      ],
      sellerId: 'seller_004',
      sellerName: 'Vintage Luxe',
      sellerImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      isFavorite: true,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    WatchModel(
      id: 'watch_006',
      brand: 'IWC',
      model: 'Portugieser Chronograph',
      year: 2021,
      condition: 'Excellent',
      price: 9800,
      description: 'IWC Portugieser Chronograph with the classic blue dial and Arabic numerals. This elegant timepiece features a 41mm case and the in-house 69355 calibre movement with 46 hours of power reserve.',
      images: [
        'https://images.unsplash.com/photo-1542496658-e33a6d0d50f6?w=800',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800',
      ],
      sellerId: 'seller_002',
      sellerName: 'Elite Watch Gallery',
      sellerImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    WatchModel(
      id: 'watch_007',
      brand: 'Vacheron Constantin',
      model: 'Overseas',
      year: 2020,
      condition: 'Excellent',
      price: 32000,
      description: 'Vacheron Constantin Overseas in 41mm stainless steel with a blue lacquered dial. Features the Maltese cross-inspired bezel and comes with three interchangeable straps. A true luxury sports watch.',
      images: [
        'https://images.unsplash.com/photo-1614164185128-e4ec99c436d7?w=800',
        'https://images.unsplash.com/photo-1594534475808-b18fc33b045e?w=800',
        'https://images.unsplash.com/photo-1619134778706-7015533a6150?w=800',
      ],
      sellerId: 'seller_003',
      sellerName: 'Horological Masters',
      sellerImage: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    WatchModel(
      id: 'watch_008',
      brand: 'Rolex',
      model: 'Daytona',
      year: 2023,
      condition: 'New',
      price: 35000,
      description: 'Rolex Cosmograph Daytona in Oystersteel with the white dial. This legendary chronograph features a tachymetric scale, three sub-dials, and is powered by the calibre 4130 movement.',
      images: [
        'https://images.unsplash.com/photo-1548171915-e79a380a2a4b?w=800',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800',
        'https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=800',
      ],
      sellerId: 'seller_001',
      sellerName: 'Premium Timepieces',
      sellerImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
      isFavorite: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static final List<MessageModel> sampleMessages = [
    MessageModel(
      id: 'msg_001',
      senderId: 'user_001',
      receiverId: 'seller_001',
      content: 'Hello, is this watch still available?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    MessageModel(
      id: 'msg_002',
      senderId: 'seller_001',
      receiverId: 'user_001',
      content: 'Yes, it is! Would you like more details or photos?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
    ),
    MessageModel(
      id: 'msg_003',
      senderId: 'user_001',
      receiverId: 'seller_001',
      content: 'Yes please, can you send me the original box photos?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
    ),
  ];

  static final List<Map<String, dynamic>> notifications = [
    {
      'id': 'notif_001',
      'title': 'Price Drop Alert',
      'message': 'A watch on your wishlist has dropped in price!',
      'time': '2 hours ago',
      'isRead': false,
    },
    {
      'id': 'notif_002',
      'title': 'New Message',
      'message': 'You have a new message from Premium Timepieces',
      'time': '5 hours ago',
      'isRead': true,
    },
    {
      'id': 'notif_003',
      'title': 'New Arrival',
      'message': 'A new Rolex Daytona has been listed',
      'time': '1 day ago',
      'isRead': true,
    },
  ];
}