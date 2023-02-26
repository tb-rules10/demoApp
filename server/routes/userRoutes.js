const {home, data} = require('../controllers/userController.js');
const router = require('express').Router(); 


router.get('/', home);
router.post("/input", data);

module.exports = router;