package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.Converter;
import vo.Goods;
import vo.GoodsImg;

public class GoodsDao extends ClassDao {
	Converter converter = null;
}