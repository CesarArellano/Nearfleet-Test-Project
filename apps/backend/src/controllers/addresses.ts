import type { Request, Response } from "express";
import { ValidationError } from "sequelize";
import Address from "../models/address";

export const getAddresses = async (req: Request, res: Response) => {
  const addreses = await Address.findAll();
  try {
    res.json({
      addreses,
    });
  } catch (error) {
    console.log({ error });
    res.status(500).json({
      msg: "Failed to retrieve addresses, please talk to the system administrator",
    });
  }
};

export const createAddress = async (req: Request, res: Response) => {
  const { body } = req;

  try {
    const address = Address.build(body);
    await address.save();

    res.json({
      msg: "Address was successfully created",
      address,
    });
  } catch (error) {
    console.log({ error });

    if (error instanceof ValidationError) {
      return res.status(500).json({
        msg: "Validation error",
        errors: error.errors.map((e) => e.message),
      });
    }

    res.status(500).json({
      msg: "Failed to create address, please talk to the system administrator",
    });
  }
};

export const updateAddress = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { body } = req;

  try {
    const address = await Address.findByPk(id);
    if (!address) {
      res.status(404).json({
        msg: "Address doesn't exist",
      });
    }

    await address?.update(body);

    res.json({
      msg: "Address was successfully updated",
      address,
    });
  } catch (error) {
    console.log({ error });
    res.status(500).json({
      msg: "Talk to the system administrator",
    });
  }
};

export const deleteAddress = async (req: Request, res: Response) => {
  const { id } = req.params;

  try {
    const address = await Address.findByPk(id);
    if (!address) {
      res.status(404).json({
        msg: "Address doesn't exist",
      });
    }

    await address?.destroy();

    res.json({
      msg: "Address was successfully deleted",
    });
  } catch (error) {
    console.log({ error });
    res.status(500).json({
      msg: "Failed to delete address, please talk to the system administrator",
    });
  }
};
