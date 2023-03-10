const {home, data, predict} = require('../controllers/userController.js');
const router = require('express').Router(); 


router.get('/', home);
router.post("/input", data);
router.post("/predict", predict);

module.exports = router;