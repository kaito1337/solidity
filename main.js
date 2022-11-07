import express from "express";
import cors from "cors";

const app = express();

let userId = 14;
let shopId = 9;
let requestId = 0;
let commId = 0;
let answerId = 0;

let users = [
{
    "id": 1, 
    "login": "shop1", 
    "name": "shop1",
    "pass": "123",
    "role": 6,
    "balance": 0,
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
    "id": 3 ,
    "login": "shop3" ,
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
    "id": 5 ,
    "login": "shop5" ,
    "name": "shop5",
    "pass": "123",
    "role": 6,
    "balance": 0 ,
    "tempRole": 6 ,
    "shopId": 5
},
{
    "id": 6 ,
    "login": "shop6" ,
    "name": "shop6",
    "pass": "123",
    "role": 6,
    "balance": 0 ,
    "tempRole": 6 ,
    "shopId": 6 
},
{
    "id": 7 ,
    "login": "shop7" ,
    "name": "shop7",
    "pass": "123",
    "role": 6,
    "balance": 0 ,
    "tempRole": 6 ,
    "shopId": 7  
},
{
    "id": 8 ,
    "login": "shop8" ,
    "name": "shop8",
    "pass": "123" ,
    "role": 6 ,
    "balance": 0 ,
    "tempRole": 6 ,
    "shopId": 8 , 
},
{
    "id": 9 ,
    "login": "shop9" ,
    "name": "shop9" ,
    "pass": "123" ,
    "role": 6 ,
    "balance": 0 ,
    "tempRole": 6 ,
    "shopId": 9 , 
},
{
    "id": 10 ,
    "login": "shop10" ,
    "name": "shop10" ,
    "pass": "123" ,
    "role": 6 ,
    "balance": 0 ,
    "tempRole": 6 ,
    "shopId": 10 , 
},
{
    "id": 11 ,
    "login": "shop11" ,
    "name": "shop11" ,
    "pass": "123" ,
    "role": 6 ,
    "balance": 0 ,
    "tempRole": 6 ,
    "shopId": 11 , 
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
    "login": "shop1"
},
{
    "id": 2,
    "city": "Kaluga",
    "employees": [],
    "login": "shop2"
},
{
    "id": 3,
    "city": "Moscow",
    "employees": [],
    "login": "shop3"
},
{
    "id": 4,
    "city": "Ryazan",
    "employees": [],
    "login": "shop4"
},
{
    "id": 5,
    "city": "Samara",
    "employees": [],
    "login": "shop5"
},
{
    "id": 6,
    "city": "Saint-Petersburg",
    "employees": [],
    "login": "shop6"
},
{
    "id": 7,
    "city": "Taganrog",
    "employees": [],
    "login": "shop7"
},
{
    "id": 8,
    "city": "Tomsk",
    "employees": [],
    "login": "shop8"
},
{
    "id": 9,
    "city": "Habarovsk",
    "employees": [],
    "login": "shop9"
}
];

let admins = ["ivan"];

let requests = [{}];

let coms = [{}];

let loans = [];

let answers = [{}];

let products = [
{
    "title": "Apple",
    "manufacturer": "China",
    "date": 050421,
    "shelfLife": 30,
    "temperature": 30,
    "izm": "kilogramm", // unit
    "price": 0.5,
}
];

app.use(cors());
app.use(express.json())

app.get("/", (req, res) => {
    res.status(200).json({ message: "Hello Express" })
})

app.post('/reg', (req, res) => {
    const { login, name, pass } = req.body;
    users.push({ "id": userId++, "login": login, "name": name, "pass": pass, "role": 1, "balance": 0, "tempRole": 0, "shopId": 0 });
    return res.status(200).json({ message: "User created" });
})
app.post('/auth', (req, res) => {
    const { login, pass } = req.body;
    const user = users.find((el) => el.login === login && el.pass == pass);
    if (user) {
        return res.status(200).json({ message: "Success auth", user});
    }
    return res.status(500).json({ error: "Wrong pair login/pass" });
})

app.post('/setAdmin', (req, res) => {
    const { login } = req.body;
    const user = users.findIndex((el) => el.login === login );
    if(user === -1){
        return res.status(500).json({ error:"User not found" });
    }
    users[user].role = 3;
    admins.push(login); 
    return res.status(200).json({message:"Success changed"});
})

app.get('/getAdmins', (req,res) => {
    return res.status(200).json({ message: "Admins: ", admins });
})

app.get('/getShops', (req,res) => {
    return res.status(200).json({ message: "Shops: ", shops });
})

app.get('/getShops', (req,res) => {
    return res.status(200).json({ message: "Shops: ", shops });
})

app.get('/getEmpl', (req,res) => {
    const id = req.query.id;
    const shop = shops.find((el) => el.id == id);
    console.log(shop)
    if(shop){
        let employees = shop.employees;
        return res.status(200).json( { message: `Employees of the shop #${id}:`, employees})
    }
    return res.status(500).json( { error: "Shop not found" } )
})

app.post('/changeRole', (req, res) => {
    const { login, role } = req.body;
    const index = users.findIndex((el) => el.login == login);
    if(index == -1){
        return res.status(500).json({error: "User not found"});
    }
    if(users[index].role == 3){
        users[index].tempRole = role;
    }
    users[index].role = role;
    return res.status(200).json({message: "Success changed role"});
})

app.post('/adminToBuyer', (req,res) => {
    const {login} = req.body;
    const index = users.findIndex((el), el.login == login );
    if(users[index].role != 3){
    return res.status(500).json({ error: "You are not admin"});
    }
    users[index].tempRole == 1;
    return res.status(200).json({ message: "Success changed"});
})

app.post('/buyerToAdmin', (req,res) => {
    const {login} = req.body;
    const index = users.findIndex((el), el.login == login );
    if(users[index].role != 3){
    return res.status(500).json({ error: "You are not admin"});
    }
    users[index].tempRole == 3;
    return res.status(200).json({ message: "Success changed"});
})

app.post('/sellerToBuyer', (req,res) => {
    const {login} = req.body;
    const index = users.findIndex((el), el.login == login );
    if(users[index].role != 2){
    return res.status(500).json({ error: "You are not seller"});
    }
    users[index].tempRole == 1;
    return res.status(200).json({ message: "Success changed"});
})

app.post('/buyerToSeller', (req,res) => {
    const {login} = req.body;
    const index = users.findIndex((el) => el.login == login );
    if(users[index].role != 2){
    return res.status(500).json({ error: "You are not seller"});
    }
    users[index].tempRole == 2;
    return res.status(200).json({ message: "Success changed"});
})

app.post('/addShop', (req,res) => {
    const {login, city} = req.body;
    const index = users.findIndex((el) => el.login == login );
    if(index == -1){
        return res.status(500).json({ error: "User not found"});
    }
    users[index].role = 6;
    shops.push({ "id": shopId++, "city": city, "employees": [], "login": users[index].login });
    return res.status(200).json({ message: "Success added shop # ", shopId});
})

app.post('/deleteShop', (req, res) => {
    const {login} = req.body;
    const index = shops.findIndex((el) => el.login == login);
    if(index == -1){
        return res.status(500).json({ error: "Shop not found"});
    }
    const userIndex = users.findIndex((el) => el.login == shops[index].login);
    users[userIndex].role = 1;
    for(let i = 0; i < shops[index].employees.length; i++){
        let userIn = users.findIndex((el) => el.login == shops[index].employees[i])
        users[userIn].role = 1;
    }
    shops.splice(index, 1);
    return res.status(200).json({message: "Success delete shop"});
})

app.post('/sendRequest', (req, res) => {
    const {id, login} = req.body;
    requests.push({"id": requestId++, "login": login, "shopId": id});
    return res.status(200).json({message: "Success"});
})

app.post('/takeRequest', (req, res) => {
    const {id, solut} = req.body;
    const index = requests.findIndex((el) => el.id == id);
    const shopIndex = shops.findIndex((el) => el.id == requests[index].shopId);
    const userIndex = user.findIndex((el) => el.login == shops[shopIndex].login);
    if(requests[index] == -1){
        return res.status(500).json({error: "Request not found"});
    }
    if(solut){
        if(users[userIndex].role == 1){
            users[userIndex].role = 2;
            users[userIndex].shopId = requests[index].shopId;
            shops[requests[index].shopId].employees.push(users[userIndex].login);
        }else{
            users[userIndex].role = 1;
            users[userIndex].shopId = 0
            for(let i = 0; i<shops[requests[index].shopId].employees.length; i++){
                if(users[userIndex].login === shops[requests[index].shopId].employees[i]){
                    shops[requests[index].shopId].employees.splice(i, 1);
                }
            }
        }
    }
    requests.splice(index, 1);
    return res.status(200).json({message: "Answer for request has been added"})
})

app.get('/getReq', (req,res) => {
    return res.status(200).json({ requests });
})

app.post('/addComm', (req, res) => {
    const { text, id, point, login} = req.body;
    if( !(point <= 10 && point >= 1)){
        return res.status(500).json({ error: "Wrong point"});
    }

    coms.push({ "id": commId++, "text": text, "shopId": id, "likes": 0, "dislikes": 0, "point": point, "sender": login });
    return res.status(200).json({ message: "Comm has been added"});
})

app.post('/likeCom', (req,res) => {
    const {id} = req.body;
    const index = coms.findIndex((el) => el.id == id);
    if(index == -1){
        return res.status(500).json({ error: "Comm not found"});
    }
    coms[index].likes++;
    return res.status(500).json({message: "Like has been added"});
})

app.post('/dislikeCom', (req,res) => {
    const {id} = req.body;
    const index = coms.findIndex((el) => el.id == id);
    if(index == -1){
        return res.status(500).json({ error: "Comm not found"});
    }
    coms[index].dislikes++;
    return res.status(500).json({message: "Dislike has been added"});
})

app.post('/takeLoan', (req, res) => {
    const {login} = req.body;
    loans.push(login);
    return res.status(200).json({message: "Success request"});
})

app.post('/giveLoan', (req, res) => {
    const {id, solut} = req.body;
    const index = users.findIndex((el) => el.login == loans[id]);
    if(index == -1){
        return res.status(500).json({error: "User not found"});
    }
    if(solut){
        users[index].balance += 1000;
        return res.status(200).json({message: "Success give a loan"});
    }
    loans.splice(id,1);
})

app.post('/addAnswer', (req,res) => {
    const {parent, text, login} = req.body;
    const index = coms.findIndex((el) => el.id == parent);
    if(index == -1){
        return res.status(500).json({error: "Comment not found"});
    }
    answers.push({"id": answerId++, "sender": login, "parent": parent, "text": text, "likes": 0, "dislikes": 0})

})

app.post('/likeAns', (req,res) => {
    const {id} = req.body;
    const index = answers.findIndex((el) => el.id == id);
    if(index == -1){
        return res.status(500).json({ error: "Answer not found"});
    }
    answers[index].likes++;
    return res.status(500).json({message: "Like has been added"});
})

app.post('/dislikeAns', (req,res) => {
    const {id} = req.body;
    const index = answers.findIndex((el) => el.id == id);
    if(index == -1){
        return res.status(500).json({ error: "Answer not found"});
    }
    answers[index].dislikes++;
    return res.status(500).json({message: "Dislike has been added"});
})

app.get('/getAnswers', (req, res) => {
    const {parent} = req.query.parent;
    const index = coms.findIndex((el) => el.parent == parent);
    if(index == -1){
        return res.status(500).json({error: "Comment not found"});
    }
    const answers = answers.map((el) => el.parent == parent);
    return res.status(200).json({answers});
})

app.post('/createProduct', (req, res) => {
    const {title, manufacturer, date, shelfLife, temperature, izm, price} = req.body;
    products.push({title, manufacturer, date, shelfLife, temperature, izm, price});
    return res.status(200).json({message: "Success added a new product"});
})

app.get('/getProducts', (req, res) => {
    return res.status(200).json({products});
})

app.get('/getRate', (req, res) => {
})

app.listen(3000, () => console.log("Server started on port 3000"))
