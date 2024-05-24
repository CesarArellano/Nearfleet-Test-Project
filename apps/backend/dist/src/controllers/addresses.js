"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteAddress = exports.updateAddress = exports.createAddress = exports.getAddresses = void 0;
const sequelize_1 = require("sequelize");
const address_1 = __importDefault(require("../models/address"));
const getAddresses = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const addreses = yield address_1.default.findAll();
    try {
        res.json({
            addreses,
            msg: "Ok",
        });
    }
    catch (error) {
        console.log({ error });
        res.status(500).json({
            msg: "Failed to retrieve addresses, please talk to the system administrator",
        });
    }
});
exports.getAddresses = getAddresses;
const createAddress = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { body } = req;
    try {
        const address = address_1.default.build(body);
        yield address.save();
        res.json({
            msg: "Address was successfully created",
            address,
        });
    }
    catch (error) {
        console.log({ error });
        if (error instanceof sequelize_1.ValidationError) {
            return res.status(500).json({
                msg: "Validation error",
                errors: error.errors.map((e) => e.message),
            });
        }
        res.status(500).json({
            msg: "Failed to create address, please talk to the system administrator",
        });
    }
});
exports.createAddress = createAddress;
const updateAddress = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const { body } = req;
    try {
        const address = yield address_1.default.findByPk(id);
        if (!address) {
            res.status(404).json({
                msg: "Address doesn't exist",
            });
        }
        yield (address === null || address === void 0 ? void 0 : address.update(body));
        res.json({
            msg: "Address was successfully updated",
            address,
        });
    }
    catch (error) {
        console.log({ error });
        res.status(500).json({
            msg: "Talk to the system administrator",
        });
    }
});
exports.updateAddress = updateAddress;
const deleteAddress = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    try {
        const address = yield address_1.default.findByPk(id);
        if (!address) {
            res.status(404).json({
                msg: "Address doesn't exist",
            });
        }
        yield (address === null || address === void 0 ? void 0 : address.destroy());
        res.json({
            msg: "Address was successfully deleted",
        });
    }
    catch (error) {
        console.log({ error });
        res.status(500).json({
            msg: "Failed to delete address, please talk to the system administrator",
        });
    }
});
exports.deleteAddress = deleteAddress;
//# sourceMappingURL=addresses.js.map