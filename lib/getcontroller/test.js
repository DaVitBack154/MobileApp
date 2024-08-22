socket.on("getStatusRead", async (data) => {
  try {
    const { id_card } = data;

    const messages = await Modelchatuser.find({
      id_card: id_card,
      status_read: { $in: ["SU", "SA"] },
    });

    // นับจำนวนของแต่ละสถานะ
    const countSU = messages.filter((msg) => msg.status_read === "SU").length;
    const countSA = messages.filter((msg) => msg.status_read === "SA").length;

    const results = {
      totalCount: messages.length,
      countSU: countSU,
      countSA: countSA,
      messages: messages,
    };

    socket.emit("initialRead", results); // ส่งผลลัพธ์กลับไปยัง client ผ่าน event 'initialRead'
  } catch (error) {
    socket.emit("error", "Error retrieving messages"); // ส่งข้อความ error กลับไปยัง client
  }
});
