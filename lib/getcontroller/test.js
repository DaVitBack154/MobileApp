const getPaginatedMessages = async (page, limit, id_card = '') => {
  const skip = +limit * +page - limit;

  // หาจำนวนข้อความทั้งหมดที่ตรงกับ id_card
  const totalMessages = await Modelchatuser.countDocuments({
    id_card: id_card,
  });

  // คำนวณจำนวนหน้าทั้งหมด
  const totalPages = Math.ceil(totalMessages / limit);

  // หาก page ที่ต้องการเกินจำนวนหน้าทั้งหมด ให้ return ค่าว่าง
  if (page > totalPages) {
    return {
      page: +page,
      limit: +limit,
      total: totalMessages,
      totalPages,
      data: [],
    };
  }

  // ค้นหาข้อความที่ตรงกับ page ปัจจุบัน
  const res = await Modelchatuser.find({ id_card: id_card })
    .skip(skip)
    .limit(limit)
    .exec();

  const results = res?.map((item, i) => ({
    rows: i + 1 + skip,
    ...item?._doc,
  }));

  return {
    page: +page,
    limit: +limit,
    total: totalMessages,
    totalPages,
    data: results,
  };
};

ที่ต้องใช้คือส่วนนี้
  socket.on('viewsMessageUser', async (data) => {
    if (!data || !data.CardID) {
      socket.emit('initialMessagesUser', { message: 'ต้องระบุ CardID' });
      return;
    }

    try {
      const messageUser = await getPaginatedMessages(
        data.Page || 1,
        data.Limit || 10,
        data.CardID
      );

      if (messageUser?.data?.length === 0) {
        socket.emit('initialMessagesUser', { message: 'ไม่พบข้อความ' });
        return;
      }

      const _listMessage = messageUser?.data?.map((v) => ({
        rows: v.rows,
        _id: v._id.toString(),
        sender: v?.sender ?? '',
        message: v?.message ?? '',
        reciever: v?.reciever ?? '',
        type: v?.type ?? '',
        status_read: v?.status_read ?? '',
        status_connect: v?.status_connect ?? '',
        role: v?.role ?? '',
        id_card: v?.id_card ?? '',
        status_end: v?.status_end ?? '',
        image:
          v?.image?.length > 0
            ? v?.image?.map((v) => `http://${urlHost}:4000/upload/img/${v}`)
            : [],
        createdAt: v.createdAt ?? '',
      }));

      socket.emit('initialMessagesUser', _listMessage);
    } catch (error) {
      console.error('Error fetching messages via socket:', error);
      socket.emit('initialMessagesUser', {
        message: 'เกิดข้อผิดพลาดในการดึงข้อความ',
      });
    }
  });
