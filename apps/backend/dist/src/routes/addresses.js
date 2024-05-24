"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const addresses_1 = require("../controllers/addresses");
const router = (0, express_1.Router)();
router.get("/", addresses_1.getAddresses);
router.post("/", addresses_1.createAddress);
router.put("/:id", addresses_1.updateAddress);
router.delete("/:id", addresses_1.deleteAddress);
exports.default = router;
//# sourceMappingURL=addresses.js.map