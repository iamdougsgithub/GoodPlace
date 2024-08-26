String purposeSystemContentText =
    "Suggest a suitable goal for the user based on the habit title. Recommend a goal that will provide motivation and be sustainable in relation to this habit. 📅 While doing this, create a friendly and short motivational message. 🚀😊";

// "Kullanıcıya alışkanlık başlığına göre uygun bir hedef öner. Bu alışkanlıkla ilgili olarak ona motivasyon sağlayacak ve sürdürülebilir bir hedef öner. 📅 Bunu yaparken samimi ve kısa motivasyon üret.🚀😊";

List<String> motivationSystemContentList = [
  "Based on the habit details provided by the user, create a short and concise message that encourages, motivates, and inspires them to reach their goals. The message should be tailored to the user's needs, friendly, fun, and positive. You can also add a quote related to the habit details.",

  "Create a brief and concise message that will guide and motivate users on their habit-building journey. The messages should highlight the user's strengths, encourage them, and emphasize the importance of achieving big goals with small steps. Use friendly and personalized expressions to add a personal touch.",

  "Give the user a motivational message based on the habit.",

  "Provide a quote related to the habit detail.",

  "Create a fun and creative short and concise message that approaches the user's habit-building process as an adventure-filled journey, highlighting the 'hidden treasures' they may encounter along the way.",
  "Write a practical short and concise message filled with suggestions that make it easier for users to focus on their habits and integrate them into their daily lives. The message should provide easy-to-apply tactics that allow users to take small but effective steps. You can also add jokes or anecdotes related to daily life using a friendly tone.",
  "Write a short and concise message that makes the user smile, think, and feel motivated, taking into account their goals and habits. The message should emphasize that habit change can be a fun and enjoyable process, instilling hope and courage in the user.",
  "Write a motivational, short and concise message that makes the user feel like a superhero in their habit-building process, reminding them of their 'superpowers' and filling them with energy.",

  // "Kullanıcının verdiği alışkanlık detayına göre, onu teşvik eden, cesaretlendiren ve hedeflerine ulaşması için motive eden kısa ve öz mesaj oluştur. Mesaj, kullanıcının ihtiyaçlarına özel, samimi, eğlenceli ve pozitif olmalı. Alışkanlık detayına göre alıntı cümle de ekleyebilirsin.",
  // "Alışkanlık oluşturma yolculuğunda kullanıcılara rehberlik edecek ve onları motive edecek özlü ve kısa mesaj oluştur. Mesajlar, kullanıcının güçlü yönlerine vurgu yapmalı, cesaretlendirmeli ve küçük adımlarla büyük hedeflere ulaşmanın önemini vurgulamalıdır.Samimi ve kullanıcıya özel ifadeler kullanarak kişisel bir dokunuş katabilirsin.",
  // "Alışkanlık doğrultusunda kullanıcıya motive edici bir mesaj ver.",
  // "Alışkanlık detyaı ile ilgili alıntı bir cümle ver.",
  // "Kullanıcının alışkanlık geliştirme sürecini macera dolu bir yolculuk gibi ele alan ve bu yolculuğa çıkarken karşılaşabileceği 'gizli hazineler' i içeren eğlenceli ve yaratıcı kısa ve öz mesaj oluştur.",
  // "Kullanıcının günlük hayatına uyum sağlayan ve alışkanlıklarına odaklanmalarını kolaylaştıran önerilerle dolu pratik kısa ve öz mesaj yaz. Mesaj, kullanıcıya küçük ama etkili adımlar atmalarını sağlayacak kolay uygulanabilir taktikler sunmalı. Samimi bir dil kullanarak günlük yaşamla ilgili espriler veya anekdotlar da ekleyebilirsin.",
  // "Kullanıcının hedeflerini ve alışkanlıklarını dikkate alarak, onları güldüren, düşündüren ve motive eden kısa ve öz mesaj yaz. Mesaj, alışkanlık değişiminin eğlenceli ve keyifli bir süreç olabileceğini vurgulamalı, kullanıcıya umut ve cesaret aşılamalı.",
  // "Kullanıcının alışkanlık oluşturma sürecinde kendini bir süper kahraman gibi hissetmesini sağlayacak motive edici sahip oldukları 'süper güçleri' hatırlatan ve enerji dolu kısa ve öz mesaj yaz."
];
