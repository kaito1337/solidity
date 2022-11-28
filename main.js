import express from "express";
import cors from "cors";

const app = express();

app.use(cors());
app.use(express.json())

let users = [
    {
        "id": 1,
        "login": "shop1",
        "name": "shop1",
        "pass": "123",
        "role": 6,
        "balance": 50,
        "tempRole": 6,
        "shopId": 1,
    },
    {
        "id": 2,
        "login": "shop2",
        "name": "shop3",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 2
    },
    {
        "id": 3,
        "login": "shop3",
        "name": "shop3",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 3
    },
    {
        "id": 4,
        "login": "shop4",
        "name": "shop4",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 4
    },
    {
        "id": 5,
        "login": "shop5",
        "name": "shop5",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 5
    },
    {
        "id": 6,
        "login": "shop6",
        "name": "shop6",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 6
    },
    {
        "id": 7,
        "login": "shop7",
        "name": "shop7",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 7
    },
    {
        "id": 8,
        "login": "shop8",
        "name": "shop8",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 8,
    },
    {
        "id": 9,
        "login": "shop9",
        "name": "shop9",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 9,
    },
    {
        "id": 10,
        "login": "shop10",
        "name": "shop10",
        "pass": "123",
        "shopId": 10,
        "role": 6,
        "balance": 0,
        "tempRole": 6,
    },
    {
        "id": 11,
        "login": "shop11",
        "name": "shop11",
        "pass": "123",
        "role": 6,
        "balance": 0,
        "tempRole": 6,
        "shopId": 11,
    },
    {
        "id": 12,
        "login": "ivan",
        "name": "Ivanov Ivan Ivanovich",
        "pass": "123",
        "role": 3,
        "balance": 50,
        "tempRole": 3,
        "shopId": 0
    },
    {
        "id": 13,
        "login": "semen",
        "pass": "123",
        "name": "Semenov Semen Semenovich",
        "role": 2,
        "balance": 70,
        "tempRole": 2,
        "shopId": 1,
    },
    {
        "id": 14,
        "login": "petr",
        "pass": "123",
        "name": "Petrov Petr Petrovich",
        "role": 1,
        "balance": 110,
        "tempRole": 1,
        "shopId": 0,
    },
    {
        "id": 15,
        "login": "goldfish",
        "pass": "123",
        "name": "goldfish",
        "role": 4,
        "balance": 100,
        "tempRole": 4,
        "shopId": 0,
    },
    {
        "id": 16,
        "login": "ugin",
        "pass": "123",
        "name": "Evgenieva Evgeniya Evgenivna",
        "role": 2,
        "balance": 80,
        "tempRole": 2,
        "shopId": 3,
    },
    {
        "id": 17,
        "login": "dima",
        "pass": "123",
        "name": "Dmitriev Dmitriy Dmitrievich",
        "role": 2,
        "balance": 90,
        "tempRole": 2,
        "shopId": 5,
    },
    {
        "id": 18,
        "login": "vasya",
        "pass": "123",
        "name": "Vasilyev Vasiliy Vasilyevich",
        "role": 2,
        "balance": 100,
        "tempRole": 2,
        "shopId": 7,
    },
    {
        "id": 19,
        "login": "igor",
        "pass": "123",
        "name": "Igorev Igor Igorevich",
        "role": 2,
        "balance": 150,
        "tempRole": 2,
        "shopId": 8,
    },
    {
        "id": 20,
        "login": "roman",
        "pass": "123",
        "name": "Romanov Roman Romanovich",
        "role": 1,
        "balance": 80,
        "tempRole": 1,
        "shopId": 0,
    },
    {
        "id": 21,
        "login": "nikola",
        "pass": "123",
        "name": "Nikolaev Nikolay Nikolaevich",
        "role": 1,
        "balance": 90,
        "tempRole": 1,
        "shopId": 0,
    },
    {
        "id": 22,
        "login": "oleg",
        "pass": "123",
        "name": "Olegov Oleg Olegovich",
        "role": 1,
        "balance": 100,
        "tempRole": 1,
        "shopId": 0,
    },
    {
        "id": 23,
        "login": "alex",
        "pass": "123",
        "name": "Alexandrova Alexandra Alexandrovna",
        "role": 1,
        "balance": 120,
        "tempRole": 1,
        "shopId": 0,
    }
];

let shops = [{
    "id": 1,
    "city": "Dmitrov",
    "employees": ["semen"],
    "login": "shop1",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 2,
    "city": "Kaluga",
    "employees": [],
    "login": "shop2",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 3,
    "city": "Moscow",
    "employees": ["ugin"],
    "login": "shop3",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 4,
    "city": "Ryazan",
    "employees": [],
    "login": "shop4",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 5,
    "city": "Samara",
    "employees": ["dima"],
    "login": "shop5",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 6,
    "city": "Saint-Petersburg",
    "employees": [],
    "login": "shop6",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 7,
    "city": "Taganrog",
    "employees": ["vasya"],
    "login": "shop7",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 8,
    "city": "Tomsk",
    "employees": ["igor"],
    "login": "shop8",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
},
{
    "id": 9,
    "city": "Habarovsk",
    "employees": [],
    "login": "shop9",
    "rate": 0,
    "products": [{}],
    "orders": [{}],
    "returns": [{}]
}
];

let admins = ["ivan"];

let requests = [{}];

let coms = [
    {
        "text": "Отличное качество товара!",
        "id": 1,
        "parent": 1,
        "point": 10,
        "login": "10",
        "likes": 25,
        "dislikes": 0,
        "answers": [{
            "text": "подтверждаю",
            "id": 1,
            "login": "petr",
            "point": 9,
            "likes": 20,
            "dislikes": 2
        }]
    },
    {
        "text": "Быстрое обслуживание",
        "id": 2,
        "parent": 1,
        "point": 9,
        "login": "petr",
        "likes": 15,
        "dislikes": 1,
        "answers": [{
            "text": "А я долго ждал(((",
            "id": 1,
            "login": "nikola",
            "point": 2,
            "likes": 0,
            "dislikes": 11
        },
        {
            "text": "Магазин приносит свои извинения",
            "id": 2,
            "login": "semen",
            "point": 0,
            "likes": 40,
            "dislikes": 15
        }]
    },
    {
        "text": "Ничего особенного",
        "id": 3,
        "parent": 3,
        "point": 5,
        "login": "roman",
        "likes": 3,
        "dislikes": 20,
        "answers": [{
            "text": "Не согласен с вами, всё супер!",
            "id": 1,
            "login": "petr",
            "point": 10,
            "likes": 15,
            "dislikes": 0
        }]
    },
    {
        "text": "Спасибо мне всё понравилось!",
        "id": 4,
        "parent": 3,
        "point": 8,
        "login": "alex",
        "likes": 23,
        "dislikes": 1,
        "answers": [{
            "text": "И мне!",
            "id": 1,
            "login": "roman",
            "point": 9,
            "likes": 36,
            "dislikes": 5
        }]
    },
    {
        "text": "Мне нахамил продавец.",
        "id": 5,
        "parent": 8,
        "point": 1,
        "login": "alex",
        "likes": 10,
        "dislikes": 2,
        "answers": [{
            "text": "Поддерживаю",
            "id": 1,
            "login": "petr",
            "point": 2,
            "likes": 11,
            "dislikes": 0
        }]
    },
    {
        "text": "Сервис на троечку",
        "id": 6,
        "parent": 8,
        "point": 3,
        "login": "oleg",
        "likes": 15,
        "dislikes": 2,
        "answers": [{
        }]
    }];

let loans = [];

let products = [
    {
        "title": "Креветка",
        "manufacturer": "Россия",
        "date": "5/4/21",
        "shelfLife": 30,
        "minTemperature": -20,
        "maxTemperature": -5,
        "izm": "КГ", // unit
        "price": 0.03,
    }
];

let deliveryRequests = [
    {
        "shopId": 2,
        "title": "Apple",
        "count": 20,
        "price": 5,
        "status": false,
        "deliveryTemperature": [],
    }
];

function transfer(from, to, value) {
    let result = false;
    if (users[from].balance >= value) {
        users[from].balance -= value;
        users[to].balance += value;
        result = true;
    }
    return result;
}

app.get("/", (req, res) => {
    res.status(200).json({ message: "Hello Express" })
})

app.post('/reg', (req, res) => {
    const { login, name, pass } = req.body;
    let id = users.length;
    users.push({ "id": id, "login": login, "name": name, "pass": pass, "role": 1, "balance": 0, "tempRole": 1, "shopId": 0 });
    return res.status(200).json({ message: "User created" });
})
app.post('/auth', (req, res) => {
    const { login, pass } = req.body;
    const user = users.find((el) => el.login === login && el.pass == pass);
    if (user) {
        return res.status(200).json({ message: "Success auth", user });
    }
    return res.status(500).json({ error: "Wrong pair login/pass" });
})

app.post('/setAdmin', (req, res) => {
    const { login } = req.body;
    const user = users.findIndex((el) => el.login === login);
    if (user === -1) {
        return res.status(500).json({ error: "User not found" });
    }
    users[user].role = 3;
    admins.push(login);
    return res.status(200).json({ message: "Success changed" });
})

app.get('/getAdmins', (req, res) => {
    return res.status(200).json({ message: "Admins: ", admins });
})

app.get('/getShops', (req, res) => {
    return res.status(200).json({ message: "Shops: ", shops });
})

app.get('/getEmpl', (req, res) => {
    const id = req.query.id;
    const shop = shops.find((el) => el.id == id);
    console.log(shop)
    if (shop) {
        let employees = shop.employees;
        return res.status(200).json({ message: `Employees of the shop #${id}:`, employees })
    }
    return res.status(500).json({ error: "Shop not found" })
})

app.post('/changeRole', (req, res) => {
    const { login, role } = req.body;
    const index = users.findIndex((el) => el.login == login);
    if (index == -1) {
        return res.status(500).json({ error: "User not found" });
    }
    if (users[index].role == 3) {
        users[index].tempRole = role;
    }
    users[index].role = role;
    return res.status(200).json({ message: "Success changed role" });
})

app.post('/adminToBuyer', (req, res) => {
    const { login } = req.body;
    const index = users.findIndex((el), el.login == login);
    if (users[index].role != 3) {
        return res.status(500).json({ error: "You are not admin" });
    }
    users[index].tempRole == 1;
    return res.status(200).json({ message: "Success changed" });
})

app.post('/buyerToAdmin', (req, res) => {
    const { login } = req.body;
    const index = users.findIndex((el), el.login == login);
    if (users[index].role != 3) {
        return res.status(500).json({ error: "You are not admin" });
    }
    users[index].tempRole == 3;
    return res.status(200).json({ message: "Success changed" });
})

app.post('/sellerToBuyer', (req, res) => {
    const { login } = req.body;
    const index = users.findIndex((el), el.login == login);
    if (users[index].role != 2) {
        return res.status(500).json({ error: "You are not seller" });
    }
    users[index].tempRole == 1;
    return res.status(200).json({ message: "Success changed" });
})

app.post('/buyerToSeller', (req, res) => {
    const { login } = req.body;
    const index = users.findIndex((el) => el.login == login);
    if (users[index].role != 2) {
        return res.status(500).json({ error: "You are not seller" });
    }
    users[index].tempRole == 2;
    return res.status(200).json({ message: "Success changed" });
})

app.post('/addShop', (req, res) => {
    const { login, city } = req.body;
    const index = users.findIndex((el) => el.login == login);
    let id = shops.length;
    if (index == -1) {
        return res.status(500).json({ error: "User not found" });
    }
    users[index].role = 6;
    shops.push({ "id": id, "city": city, "employees": [], "login": users[index].login });
    return res.status(200).json({ message: "Success added shop # ", shopId });
})

app.post('/deleteShop', (req, res) => {
    const { login } = req.body;
    const index = shops.findIndex((el) => el.login == login);
    if (index == -1) {
        return res.status(500).json({ error: "Shop not found" });
    }
    const userIndex = users.findIndex((el) => el.login == shops[index].login);
    users[userIndex].role = 1;
    for (let i = 0; i < shops[index].employees.length; i++) {
        let userIn = users.findIndex((el) => el.login == shops[index].employees[i])
        users[userIn].role = 1;
    }
    shops.splice(index, 1);
    return res.status(200).json({ message: "Success delete shop" });
})

app.post('/sendRequest', (req, res) => {
    const { shopId, login } = req.body;
    let id = requests.length;
    requests.push({ "id": id, "login": login, "shopId": shopId });
    return res.status(200).json({ message: "Success" });
})

app.post('/takeRequest', (req, res) => {
    const { id, solut } = req.body;
    const index = requests.findIndex((el) => el.id == id);
    const shopIndex = shops.findIndex((el) => el.id == requests[index].shopId);
    const userIndex = user.findIndex((el) => el.login == shops[shopIndex].login);
    if (requests[index] == -1) {
        return res.status(500).json({ error: "Request not found" });
    }
    if (solut) {
        if (users[userIndex].role == 1) {
            users[userIndex].role = 2;
            users[userIndex].shopId = requests[index].shopId;
            shops[requests[index].shopId].employees.push(users[userIndex].login);
        } else {
            users[userIndex].role = 1;
            users[userIndex].shopId = 0
            for (let i = 0; i < shops[requests[index].shopId].employees.length; i++) {
                if (users[userIndex].login === shops[requests[index].shopId].employees[i]) {
                    shops[requests[index].shopId].employees.splice(i, 1);
                }
            }
        }
    }
    requests.splice(index, 1);
    return res.status(200).json({ message: "Answer for request has been added" })
})

app.get('/getRequests', (req, res) => {
    return res.status(200).json({ requests });
})

app.post('/addComm', (req, res) => {
    const { text, shopId, point, login } = req.body;
    let id = coms.length;
    if (!(point <= 10 && point >= 1)) {
        return res.status(500).json({ error: "Wrong point" });
    }
    coms.push({ text, id, "parent": shopId, point, login, "likes": 0, "dislikes": 0, "answers": [{}] })
    return res.status(200).json({ message: "Comm has been added" });
})

app.post('/likeComm', (req, res) => {
    const { id } = req.body;
    const index = coms.findIndex((el) => el.id == id);
    if (index == -1) {
        return res.status(500).json({ error: "Comm not found" });
    }
    coms[index].likes++;
    return res.status(500).json({ message: "Like has been added" });
})

app.post('/dislikeComm', (req, res) => {
    const { id } = req.body;
    const index = coms.findIndex((el) => el.id == id);
    if (index == -1) {
        return res.status(500).json({ error: "Comm not found" });
    }
    coms[index].dislikes++;
    return res.status(500).json({ message: "Dislike has been added" });
})

app.post('/takeLoan', (req, res) => {
    const { login } = req.body;
    loans.push(login);
    return res.status(200).json({ message: "Success request" });
})

app.post('/giveLoan', (req, res) => {
    const { id, solut } = req.body;
    const index = users.findIndex((el) => el.login == loans[id]);
    if (index == -1) {
        return res.status(500).json({ error: "User not found" });
    }
    if (solut) {
        users[index].balance += 1000;
        return res.status(200).json({ message: "Success give a loan" });
    }
    loans.splice(id, 1);
})

app.post('/addAnswer', (req, res) => {
    const { id, text, login, point } = req.body;
    const index = coms.findIndex((el) => el.id == id);
    if (index == -1) {
        return res.status(500).json({ error: "Comment not found" });
    }
    if (!(point <= 10 && point >= 1)) {
        return res.status(500).json({ error: "Wrong point" });
    }
    const user = users.find((el) => el.login == login);
    if (user.role == 2) {
        point = 0;
    }
    coms[id].answers.push({ "text": text, "login": login, "point": point, "likes": 0, "dislikes": 0 })
    return res.status(200).json({ message: "Success added a answer" })
})

app.post('/likeAnswer', (req, res) => {
    const { id, parent } = req.body;
    const index = coms.findIndex((el) => el.id == parent);
    if (index == -1) {
        return res.status(500).json({ error: "Parent comm not found" });
    }

    coms[parent].answers[id].likes++;
    return res.status(500).json({ message: "Like has been added" });
})

app.post('/dislikeAnswer', (req, res) => {
    const { id, parent } = req.body;
    const index = coms.findIndex((el) => el.id == parent);
    if (index == -1) {
        return res.status(500).json({ error: "Parent comm not found" });
    }

    coms[parent].answers[id].dislikes++;
    return res.status(500).json({ message: "Like has been added" });
})

app.get('/getAnswers', (req, res) => {
    const { id } = req.query.id;
    const index = coms.findIndex((el) => el.id == id);
    if (index == -1) {
        return res.status(500).json({ error: "Comment not found" });
    }
    return res.status(200).json(coms[id].answers);
})

app.post('/createProduct', (req, res) => {
    const { title, manufacturer, date, shelfLife, minTemperature, maxTemperature, izm, price } = req.body;
    products.push({ title, manufacturer, date, shelfLife, minTemperature, maxTemperature, izm, price });
    return res.status(200).json({ message: "Success added a new product" });
})

app.get('/getProducts', (req, res) => {

    return res.status(200).json(products);
})

app.post('/getRate', (req, res) => {
    const { shopId } = req.body;

    const index = shops.findIndex((el) => el.id == shopId);
    if (index == -1) {
        return res.status(500).json({ error: "Shop not found" });
    }
    const commArray = coms.filter((el) => el.parent == shopId);
    if (commArray.length == 0) {
        return res.status(200).json({ message: "Rate = 0" });
    }
    let sumOfComm = 0;
    let sumOfAns = 0;
    let counter = 0;
    for (let i = 0; i < commArray.length; i++) {
        if (commArray[i].likes >= 10 && commArray[i].point !== 0 && commArray[i].likes > commArray[i].dislikes) {
            sumOfComm += commArray[i].point * (commArray[i].likes / (commArray[i].likes + commArray[i].dislikes));
            for (let j = 0; j < commArray[i].answers.length; j++) {
                if (commArray[i].answers[j].likes >= 10 && commArray[i].answers[j].point !== 0 && commArray[i].answers[j].likes > commArray[i].answers[j].dislikes) {
                    sumOfAns += commArray[i].answers[j].point * (commArray[i].answers[j].likes / (commArray[i].answers[j].likes + commArray[i].answers[j].dislikes))
                    counter++
                }
            }
            counter++
        }
    }
    const rate = Math.ceil((sumOfComm + sumOfAns) / counter * 100) / 100;
    shops[index].rate = rate;
    return res.status(200).json(`Rate = ${rate}`);
})

function getDeliveryTemperature(index) {
    const product = products.find((el) => el.title == deliveryRequests[index].title);
    for (let i = 0; i < 5; i++) {
        let temperature = Math.floor(Math.random() * (product.maxTemperature - product.minTemperature + 1) + product.minTemperature)
        deliveryRequests[index].deliveryTemperature.push(temperature);
    }
}

function checkTemperatureOut(index) {
    const product = products.find((el) => el.title == deliveryRequests[index].title);
    let discountCounter = 0;
    for (let i of deliveryRequests[index].deliveryTemperature) {
        if (i < product.minTemperature || i > product.maxTemperature) {
            discountCounter++;
        }
    }
    if (discountCounter !== 0) {
        deliveryRequests[index].price -= deliveryRequests[index].price * (discountCounter * 0.1);
    }
    return discountCounter;
}

app.post('/requestDelivery', (req, res) => {
    const { shopId, title, count } = req.body;
    const product = products.find((el) => el.title == title);
    const shop = shops.find((el) => el.id == shopId);
    if (shop) {
        if (product) {
            let cof = count <= 100 ? 1 : count <= 1000 ? 0.95 : 0.9
            let price = Math.ceil((product.price - (product.price * shop.rate) / 100) * count * cof * 100000) / 100000;
            deliveryRequests.push({ shopId, title, count, price, status: false, deliveryTemperature: [] });
            return res.status(200).json({ message: `Success added a request, price = ${price}` });
        }
        return res.status(500).json({ error: "Product not found" })
    }
    return res.status(500).json({ error: "Shop not found" })
})

app.get('/getDelivery', (req, res) => {
    return res.status(200).json(deliveryRequests);
})

app.get('/getMyDelivery', (req,res) => {
    const shopId = req.query.shopId;
    const index = deliveryRequests.findIndex((el) => el.shopId == shopId);
    return res.status(200).json(deliveryRequests[index]);
})

app.post('/acceptPrice', (req, res) => {
    const { solution, shopId } = req.body;
    const index = deliveryRequests.findIndex((el) => el.shopId == shopId);
    if (index == -1) {
        return res.status(500).json({ error: "Request not found" })
    }
    if (solution) {
        deliveryRequests[index].status = solution;
        return res.status(500).json({ message: "Price accepted" });
    } else {
        deliveryRequests.splice(index, 1);
        return res.status(500).json({ message: "Price canceled" });
    }
});

app.post('/acceptDelivery', (req, res) => {
    const { solution, shopId } = req.body;
    const index = deliveryRequests.findIndex((el) => el.shopId == shopId);
    if (index == -1) {
        return res.status(500).json({ error: "Request not found" })
    }
    const shopIndex = shops.findIndex((el) => el.id == shopId);
    const user = users.findIndex((el) => el.login == shops[shopIndex].login);
    const vendor = users.findIndex((el) => el.login == "goldfish");
    const productIndex = products.findIndex((el) => el.title == deliveryRequests[index].title)
    getDeliveryTemperature(index);
    let counter = checkTemperatureOut(index);
    if (counter == 0) {
        if (transfer(user, vendor, deliveryRequests[index].price)) {
            shops[shopIndex].products.push({ ...products[productIndex], "price": products[productIndex].price += products[productIndex].price * 0.5, "count": deliveryRequests[index].count });
            deliveryRequests.splice(index, 1);
        } else {
            return res.status(500).json({ error: "Not enough money" })
        }
    } else if (solution) {
        if (transfer(user, vendor, deliveryRequests[index].price)) {
            shops[shopIndex].products.push({ ...products[productIndex], "price": products[productIndex].price += products[productIndex].price * 0.5, "count": deliveryRequests[index].count });
            deliveryRequests.splice(index, 1);
            return res.status(200).json({ message: "Delivery accepted" })
        }else{
            return res.status(500).json({ error: "Not enough money" })
        }
    }else {
        deliveryRequests.splice(index, 1);
        return res.status(200).json({ message: "Delivery canceled" });
    }})


app.post('/orderProduct', (req, res) => {
    const { login, shopId, title, count } = req.body;
    const index = products.findIndex((el) => el.title == title);
    const shopIndex = shops.findIndex((el) => el.id == shopId);
    const productPrice = products[index].price;
    if (index == -1 || shopIndex == -1) {
        return res.status(500).json({ error: "Product or shop not found" });
    }
    const id = shops[shopIndex].orders.length + 1;
    shops[shopIndex].orders.push({ id, "customer": login, "product": title, count, "price": count * productPrice, "status": false })
    return res.status(200).json({ message: "Order created" });
})

app.post('/acceptOrder', (req, res) => {
    const { solution, orderId, shopId } = req.body;
    const shopIndex = shops.findIndex((el) => el.id == shopId);
    const orderIndex = shops[shopIndex].orders.findIndex((el) => el.id == orderId);
    const userIndex = users.findIndex((el) => el.login == shops[shopIndex].orders[orderIndex].customer);
    const indexShopUser = users.findIndex((el) => el.login == shops[shopIndex].login);
    const price = shops[shopIndex].orders[orderIndex].price
    if (shopIndex == -1 || orderIndex == -1) {
        return res.status(500).json({ error: "Order or shop not found" });
    }
    if (solution && transfer(userIndex, indexShopUser, price)) {
        shops[shopIndex].orders[orderIndex].status = true;
        return res.status(200).json({ message: "Success sell" });
    }
})

app.post('/cancelOrder', (req, res) => {
    const { orderId, login, shopId } = req.body;
    const shopIndex = shops.findIndex((el) => el.id == shopId);
    const orderIndex = shops[shopIndex].orders.findIndex((el) => el.id == orderId);
    if (shopIndex == -1 || orderIndex == -1 || shops[shopIndex].orders[orderIndex].customer != login) {
        return res.status(500).json({ error: "Order or shop not found or you are not customer" });
    }
    if (shops[shopIndex].orders[orderIndex].status == false) {
        shops[shopIndex].orders.splice(orderIndex, 1);
        return res.status(200).json({ message: "Success cancel order" });
    } else {
        return res.status(500).json({ error: "Order has been approved by seller" });
    }
})

app.post('/returnProduct', (req, res) => {
    const { orderId, shopId, login } = req.body;
    const shopIndex = shops.findIndex((el) => el.id == shopId);
    const orderIndex = shops[shopIndex].orders.findIndex((el) => el.id == orderId);
    if (shopIndex == -1 || orderIndex == -1 || shops[shopIndex].orders[orderIndex].customer != login) {
        return res.status(500).json({ error: "Order or shop not found or you are not customer" });
    }
    const id = shops[shopIndex].returns.length + 1;
    shops[shopIndex].returns.push({ id, orderId, "status": false });
    return res.status(200).json({ message: "Success created a request" });
})

app.post('/checkReturn', (req, res) => {
    const { solution, shopId, returnId } = req.body;
    const shopIndex = shops.findIndex((el) => el.id == shopId);
    const returnIndex = shops[shopIndex].returns.findIndex((el) => el.id == returnId);
    if (shopIndex == -1 || returnIndex == -1) {
        return res.status(500).json({ error: "Return or shop not found" });
    }
    const order = shops[shopIndex].orders.find((el) => el.id == shops[shopIndex].returns[returnId].orderId);
    const userIndex = users.findIndex((el) => el.login == order.customer);
    const productIndex = shops[shopIndex].products.findIndex((el) => el.title == order.product);
    const indexShopUser = users.findIndex((el) => el.login == shops[shopIndex].login);
    const price = order.price;
    if (solution && transfer(users[indexShopUser], users[userIndex], price)) {
        shops[shopIndex].products[productIndex].count += order.count;
        shops[shopIndex].returns[returnIndex].status = solution;
        return res.status(200).json({ message: "Order return approved" });
    }
    shops[shopIndex].returns[returnIndex].status = false;
    return res.status(200).json({ message: "Order has been rejected" });
})
app.listen(4000, () => console.log("Server started on port 4000"))
