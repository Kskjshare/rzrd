var menudata = {
    'my': {
        'text': '基础信息',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'welcome': {
                'text': '基础信息管理',
                'powerid': '1',
                'children': {
                    'head': {
                        'text': '首页',
                        'url': '/suggest/homepage.jsp'
                    },
                    'representative': {
                        'text': '代表管理',
                        'url': '/delegate/list.jsp',
                        'powerid': '2',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增代表',
                            },
                            'edit': {
                                'text': '编辑代表',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'import': {
                                'text': '导入',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'delegation': {
                        'text': '代表团管理',
                        'url': '/delegation/list.jsp',
                        'powerid': '3',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增代表团',
                            },
                            'edit': {
                                'text': '编辑代表团',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'company': {
                        'text': '单位管理',
                        'url': '/company/list.jsp',
                        'powerid': '4',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增单位',
                            },
                            'edit': {
                                'text': '编辑单位',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'companyuser': {
                        'text': '单位联系人',
                        'powerid': '5',
                        'url': '/company/companyuser/list.jsp',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增单位',
                            },
                            'edit': {
                                'text': '编辑单位',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'zhuanweihui': {
                        'text': '专委会管理',
                        'url': '/committee/list.jsp',
                        'powerid': '225',
                    },
                    'xiaozuguanli': {
                        'text': '考核小组管理',
                        'url': '/delegation/group/list.jsp',
                        'powerid': '269',
                    },
                }
            },
            'recharge': {
                'text': '系统管理',
                'powerid': '6',
                'children': {
                    'staff': {
                        'text': '用户管理',
                        'url': '/staff/list.jsp',
                        'powerid': '7',
                    },
                    'power': {
                        'text': '权限管理',
                        'url': '/staff/powerlist/list.jsp',
                        'powerid': '8',
                    },
                    'group': {
                        'text': '角色管理',
                        'url': '/staff/power/group/list.jsp',
                        'powerid': '9',
                    },
                    'position': {
                        'text': '日志管理',
                        'url': '/staff/position/list.jsp',
                        'powerid': '10',
                    },
//                    'department': {
//                        'text': '用户组',
//                        'url': '/staff/department/list.jsp',
//                        'powerid': '11',
//                    }
                }
            },
            'settings': {
                'text': '设置管理',
                'powerid': '12',
                'children': {
                    'code': {
                        'text': '代码管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '13',
                    },
                    'dictionary': {
                        'text': '字典管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '14',
                    },
                    'meeting': {
                        'text': '会议管理',
                        'url': '/staff/meeting/list.jsp',
                        'powerid': '11',
                    },
                    'timer': {
                        'text': '届次管理',
                        'url': '/setup/session/list.jsp',
                        'powerid': '15',
                    },
                    'companytypeee': {
                        'text': '会议次数管理',
                        'powerid': '0',
                        'url': '/setup_1/companytypeee/list.jsp'
                    },
                    'companytype': {
                        'text': '单位分类管理',
                        'url': '/setup/companytype/list.jsp',
                        'powerid': '0',
                    },
                    'conf': {
                        'text': '配置管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '16',
                    },
                    'statistics': {
                        'text': '统计管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '17',
                    },
                    'reports': {
                        'text': '报表管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '18',
                    },
                    'version': {
                        'text': '版本',
                        'powerid': '19',
                        'url': '/version/list.jsp'
                    },
                    'companytypee': {
                        'text': '审查分类管理',
                        'powerid': '173',
                        'url': '/setup_1/companytypee/list.jsp'
                    },
                    'mingancitype': {
                        'text': '敏感词库管理',
                        'powerid': '184',
                        'url': '/setup_1/mingancitype/list.jsp'
                    },
                    'feedback': {
                        'text': '意见反馈管理',
                        'url': '/meetfeedback/list.jsp',
                        'powerid': '173',
                    },
                    'partytype': {
                        'text': '党派管理',
                        'url': '/setup_1/partytype/list.jsp',
                        'powerid': '190',
                    }
                }
            }
        }
    },
    'top2': {
        'text': '履职管理',
        'powerid': '20',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
//            'consult4': {
//                'text': '“三个满意度”测评',
//                'powerid': '27',
//                'children': {
//                    'monitor4': {
//                        'text': '“一府一委两院”专项工作满意度测评',
//                        'url': '/evaluation/government/list.jsp',
//                        'powerid': '27',
//                    },
//                    'monitor3': {
//                        'text': '代表建议办理情况满意度测评',
//                        'url': '/evaluation/evaluation/list.jsp',
//                        'powerid': '27',
//                    },
//                    'notice1': {
//                        'text': '代表履职满意度测评',
//                        'url': '/evaluation/delegation/list.jsp',
//                    },
//                }
//            },
            'consult1': {
                'text': '通知公告',
                'powerid': '21',
                'children': {
                    'notice': {
                        'text': '最新资讯',
                        'url': '/newinformation/list.jsp',
                    }
                }
            },
            'consult2': {
                'text': '履职等级',
                'powerid': '22',
                'children': {
                }
            },
            'consult3': {
                'text': '履职交流',
                'powerid': '23',
                'children': {
                }
            },
            'consult5': {
                'text': '履职管理',
                'powerid': '400',
                'children': {
                    'notice': {
                        'text': '发起履职活动',
                        'url': '/newinformation/edit_1.jsp',
                        'powerid': '401',
                    },
                    'notice1': {
                        'text': '查看履职活动',
                        'url': '/newinformation/list_1.jsp',
                        'powerid': '402',
                    },
                     'notice2': {
                        'text': '所有履职活动',
                        'url': '/newinformation/list_2.jsp',
                        'powerid': '408',
                    },
                     'notice3': {
                        'text': '履职活动审查',
                        'url': '/newinformation/butreview.jsp',
                        'powerid': '409',
                    },
                }
            },


            'consult4': {
                'text': '“三个满意度”测评',
                'powerid': '27',
                'children': {
//                     'monitor4': {
//                        'text': '“一府一委两院”专项工作满意度测评',
//                        'url': '/evaluation/government/list.jsp',
//                        'powerid': '27',
//                    },
                    'monitor3': {
                        'text': '建议办理情况满意度测评',
                        'url': '/evaluation/satisfaction/list.jsp',
                        'powerid': '27',
                    },
                     'notice1': {
                        'text': '代表履职测评',
                        'url': '/evaluation/delegation/list.jsp',
                    },
                }
            },
//            'consult4': {
//                'text': '办理单位满意度测评',
//                'powerid': '27',
//                'children': {
//                    'notice': {
//                        'text': '我的建议办理满意度测评',
//                        'url': '/evaluation/mysuggest/list.jsp',
//                    },
//                    'monitor2': {
//                        'text': '承办单位测评',
//                        'url': '/evaluation/evaluation/list.jsp',
//                        'powerid': '27',
//                    },
//                    'monitor3': {
//                        'text': '单位办理满意度测表',
//                        'url': '/evaluation/satisfaction/list.jsp',
//                        'powerid': '27',
//                    },
//                    'monitor4': {
//                        'text': '一府一委两院满意度评分',
//                        'url': '/evaluation/government/list.jsp',
//                        'powerid': '27',
//                    }
//                }
//            },
//            'consult5': {
//                'text': '代表履职满意度测评',
//                'powerid': '28',
//                'children': {
//                    'notice1': {
//                        'text': '代表履职满意度测评',
//                        'url': '/evaluation/delegation/list.jsp',
//                    },
//                    'notice': {
//                        'text': '履职详情',
//                        'url': '/lvzhilist/list.jsp',
//                    },
//                    'notice2': {
//                        'text': '评分规则',
//                        'url': '/scoringrules/list.jsp',
//                        'powerid': '29',
//                    }
//                }
//            },
//            'consult6': {
//                'text': '评分规则',
//                'children': {
//                    'notice': {
//                        'text': '评分规则',
//                        'url': '/scoringrules/list.jsp',
//                        'powerid': '29',
//                    }
//                }
//            },
            'consult7': {
                'text': '代表活动',
                'powerid': '30',
                'children': {
                    'notice1': {
                        'text': '我的活动',
                        'powerid': '31',
                        'url': '/activities/myactivities/list.jsp',
                    },
                    'notice2': {
                        'text': '发起活动',
                        'powerid': '32',
                        'url': '/activities/start/list.jsp',
                    },
                    'notice3': {
                        'text': '活动报名中',
                        'powerid': '33',
                        'url': '/activities/sign/list.jsp',
                    },
                    'notice4': {
                        'text': '活动进行中',
                        'powerid': '34',
                        'url': '/activities/ongoing/list.jsp',
                    },
                    'notice5': {
                        'text': '活动成果总结',
                        'powerid': '35',
                        'url': '/activities/summary/list.jsp',
                    },
                    'notice6': {
                        'text': '活动管理',
                        'powerid': '36',
                        'url': '/activities/admin/list.jsp',
                    }
                }
            },
            'consult8': {
                'text': '履职活动',
                'powerid': '226',
                'children': {
                    'notice1': {
                        'text': '代表视察活动',
                        'powerid': '227',
                        'url': '/activities/v2/admin/list.jsp?classify=1',
                    },
                    'notice2': {
                        'text': '专题调研活动',
                        'powerid': '228',
                        'url': '/activities/v2/admin/list.jsp?classify=2',
                    },
                    'notice3': {
                        'text': '代表小组活动',
                        'powerid': '229',
                        'url': '/activities/v2/admin/list.jsp?classify=3',
                    },
                    'notice4': {
                        'text': '执法检查活动',
                        'powerid': '230',
                        'url': '/activities/v2/admin/list.jsp?classify=4',
                    },
                    'notice5': {
                        'text': '出列席会议活动',
                        'powerid': '231',
                        'url': '/activities/v2/admin/list.jsp?classify=5',
                    },
                    'notice6': {
                        'text': '代表培训',
                        'powerid': '232',
                        'url': '/activities/v2/admin/list.jsp?classify=6',
                    },
                    'notice7': {
                        'text': '添加联系群众活动',
                        'powerid': '302',
                        'url': '/activities/contactTheMasses/list.jsp?classify=8',
                    },
                    'notice8': {
                        'text': '联系群众活动审核',
                        'powerid': '303',
                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
                    },

                }
            },
            'consult9': {
                'text': '履职管理',
                'powerid': '243',
                'children': {
                    'notice1': {
                        'text': '述职管理',
                        'powerid': '244',
                        'url': '/activities/v2/admin/list.jsp?classify=7',
                    },
                    'notice2': {
                        'text': '我的述职',
                        'powerid': '245',
                        'url': '/activities/v2/myactivities/list.jsp?classifytype=2',
                    },
                    'notice3': {
                        'text': '我的履职活动',
                        'powerid': '233',
                        'url': '/activities/v2/myactivities/list.jsp?classifytype=1',
                    },
                }
            },
            'consult10': {
                'text': '履职考核',
                'powerid': '262',
                'children': {
                    'notice1': {
                        'text': '考核管理',
                        'powerid': '263',
                        'url': '/activities/evaluation/list.jsp',
                    },
                    'notice2': {
                        'text': '计分说明管理',
                        'powerid': '264',
                        'url': '/activities/evaluation/standard/list.jsp',
                    },
                    'notice3': {
                        'text': '考核打分',
                        'powerid': '265',
                        'url': '/activities/evaluation/score/list.jsp',
                    },
                    'notice4': {
                        'text': '组织评定',
                        'powerid': '268',
                        'url': '/activities/evaluation/evaluate/list.jsp',
                    },
                }
            },
        }
    },
    'top3': {
        'text': '议案建议',
        'powerid': '37',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'guanli': {
                'text': "议案建议管理",
                'powerid': '38',
                'children': {
                    'suggest': {
                        'text': '建议管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '39',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增建议',
                            },
                            'edit': {
                                'text': '编辑建议',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点建议',
                            },
                            'butexcellent': {
                                'text': '优秀建议',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'motion': {
                        'text': '议案管理',
                        'url': '/billlist/list.jsp',
                        'powerid': '40',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },
                    
                    
                   'criticism': {
                        'text': '批评管理',
                        'url': '/listManager/criticismList.jsp',
                        'powerid': '362',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },  
                        
                   'opionview': {
                        'text': '意见管理',
                        'url': '/listManager/opinionList.jsp',
                        'powerid': '363',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },  
                    
                        
                   'inquery': {
                        'text': '质询管理',
                        'url': '/listManager/inqueryList.jsp',
                        'powerid': '364',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },  
                    
                    
                    
                    
                    
                }
            },
            'motionsubmit': {
                'text': '提交管理',
                'powerid': '41',
                'children': {
                    'motionadd': {
                        'text': '新增记录',
                        'url': '/bill/edit.jsp',
                        'powerid': '42',
                    },
                    'situation': {
                        'text': '信息提交情况',
                        'url': '/bill/see.jsp',
                        'powerid': '43',
                    }
                }
            },
            'review': {
                'text': '议案建议审查',
                'powerid': '44',
                'children': {
                    'situation': {
                        'text': '查看审查情况',
                        'url': '/examine/see.jsp',
                        'powerid': '45',
                        'note': '这是 人代委审查情况',
                    },
                    'processing': {
                        'text': '选联委审查处理',
                        'url': '/examine/handle.jsp',
                        'powerid': '46',
                    },
                    'DBTsituation': {
                        'text': '查看审查情况',
                        'url': '/examine/see_1.jsp',
                        'powerid': '159',
                        'note': '这是 代表团审查情况',
                    },
                    'DBTprocessing': {
                        'text': '代表团审查处理',
                        'url': '/examine/handle_1.jsp',
                        'powerid': '160',
                    },
                    'zfbTsituation': {
                        'text': '查看审查情况',
                        'url': '/examine/see_2.jsp',
                        'powerid': '174',
                        'note': '这是 乡镇政府办审查情况',
                    },
                    'zfbTprocessing': {
                        'text': '乡镇政府办审查处理',
                        'url': '/examine/handle_2.jsp',
                        'powerid': '175',
                    }
                }
            },
            'handle': {
                'text': '议案建议办理',
                'powerid': '47',
                'children': {
                    'company': {
                        'text': '确定办理单位',
                        'url': '/handle/confirm/see.jsp',
                        'powerid': '48',
                    },
                    'submit': {
                        'text': '议案建议交办',
                        'url': '/handle/assign/look.jsp',
                        'powerid': '49',
                    },
                    'zfbsubmit': {
                        'text': '乡镇政府办办复',
                        'url': '/handle/assign/handle_2.jsp',
                        'powerid': '183',
                    },
                    'reply': {
                        'text': '议案建议办复',
                        'url': '/handle/resume/resume.jsp',
                        'powerid': '50',
                    },
                    'monitor': {
                        'text': '办理进度监控',
                        'url': '/handle/company.jsp',
                        'powerid': '51',
                    },
                    'report': {
                        'text': '办理总结报告',
                        'url': '/handle/summary/list.jsp',
                        'powerid': '52',
                    }
                }
            },
            'consult1': {
                'text': '我领衔的议案建议',
                'powerid': '53',
                'children': {
                    'report': {
                        'text': '我领衔的列表',
                        'url': '/mysuggest/list.jsp',
                    }
                }
            },
            'consult2': {
                'text': '我联名的议案建议',
                'powerid': '54',
                'children': {
                    'report': {
                        'text': '我联名的列表',
                        'url': '/secsuggest/list.jsp',
                    }
                }
            },
            'consult3': {
                'text': '草稿箱议案建议',
                'powerid': '55',
                'children': {
                    'report': {
                        'text': '草稿箱的议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult4': {
                'text': '不予接收建议',
                'powerid': '56',
                'children': {
                    'report': {
                        'text': '不予接收议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult5': {
                'text': '申请退回建议',
                'powerid': '57',
                'children': {
                    'report': {
                        'text': '申请退回议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult5': {
                'text': '置回议案建议',
                'powerid': '170',
                'children': {
                    'report': {
                        'text': '已置回建议列表',
                        'url': '/drsuggest/list_1.jsp',
                        'powerid': '171',
                    }, 'reqport': {
                        'text': '已置回议案列表',
                        'url': '/drsuggest/list_1_1.jsp',
                        'powerid': '172',
                    }, 'reqport1': {
                        'text': '已置回批评列表',
                        'url': '/drsuggest/criticismList.jsp',
                        'powerid': '365',
                    }, 'reqport2': {
                        'text': '已置回意见列表',
                        'url': '/drsuggest/opionList.jsp',
                        'powerid': '366',
                    }, 'reqport3': {
                        'text': '已置回质询列表',
                        'url': '/drsuggest/inqueryList.jsp',
                        'powerid': '367',
                    },
                }
            },
            'consult6': {
                'text': '申请延期建议',
                'powerid': '58',
                'children': {
                    'report': {
                        'text': '申请延期议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult7': {
                'text': '对口联系专委会建议',
                'powerid': '59',
                'children': {
                    'report': {
                        'text': '对口联系专委会建议',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult100': {
                'text': '代表意见征询',
                'powerid': '24',
                'children': {
                    'submit': {
                        'text': '已提交征询意见',
                        'url': '/opinion/see.jsp',
                        'powerid': '25',
                    },
                    'monitor': {
                        'text': '意见征询情况',
                        'url': '/opinion/look.jsp',
                        'powerid': '26',
                    },
//                    'monitor2': {
//                        'text': '承办单位测评',
//                        'url': '/opinion/evaluation/list.jsp',
//                        'powerid': '24',
//                    },
//                    'monitor3': {
//                        'text': '单位办理满意度测表',
//                        'url': '/opinion/satisfaction/list.jsp',
//                        'powerid': '24',
//                    },
//                    'monitor4': {
//                        'text': '一府一委两院满意度评分',
//                        'url': '/opinion/government/list.jsp',
//                        'powerid': '24',
//                    }
                }
            },
            'statistics': {
                'text': '信息统计分析',
                'powerid': '60',
                'children': {
                    'company': {
                        'text': '议案建议统计',
                        'url': '/statistics/suggest/list.jsp',
                        'powerid': '61',
                    },
                    'submit': {
                        'text': '代表信息统计',
                        'url': '/statistics/delegateinfo/list.jsp',
                        'powerid': '62',
                    },
                    'reply': {
                        'text': '履职统计',
                        'url': '/statistics/lvzhistatistics/list.jsp',
                        'powerid': '63',
                    },
//                    'monitor': {
//                        'text': '建议办理统计',
//                        'url': '/statistics/proposal.jsp',
//                        'powerid': '64',
//                    }
                }
            },
            'inquire': {
                'text': '信息综合查询',
                'powerid': '65',
                'children': {
                    'reply': {
                        'text': '代表信息',
                        'url': '/query/delegate/list.jsp',
                        'powerid': '68',
                    },
                    'company': {
                        'text': '建议信息',
                        'url': '/query/suggest/list.jsp',
                        'powerid': '66',
                    },
                    'submit': {
                        'text': '议案信息',
                        'url': '/query/billlist/list.jsp',
                        'powerid': '67',
                    },
                    'monitor': {
                        'text': '单位信息',
                        'url': '/query/company/list.jsp',
                        'powerid': '69',
                    }
                }
            },
             'menutop3':{
                'text': "添加审查分类",
                'powerid': '368',
                'children': {
                    'notice': {
                        'text': '添加分类类别',
                        'powerid': '369',
                        'url': '/bill/tianjiafenlei.jsp',
                    },
                    
                }
            },
        }
    },
    'top4': {
        'text': '学习培训',
        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "学习课件",
                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '学习课件',
                        'url': '/training/courseware/list.jsp',
                    }
                }
            },
            'menutop2': {
                'text': "专题讲座",
                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '专题讲座',
                        'url': '/training/lecture/list.jsp',
                    }
                }
            },
            'menutop3': {
                'text': "法律法规",
                'powerid': '73',
                'children': {
                    'monitor': {
                        'text': '宪法',
                        'url': '/training/statute/xianfa/list.jsp',
                    },
                    'monitor1': {
                        'text': '国家法律',
                        'url': '/training/statute/guofa/list.jsp',
                    },
                    'monitor2': {
                        'text': '相关法规',
                        'url': '/training/statute/fagui/list.jsp',
                    }
                }
            },
            'menutop4': {
                'text': "履职参考",
                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '履职参考',
                        'url': '/training/reference/list.jsp',
                    }
                }
            }
        }
    },
    'top5': {
        'text': '工作交流1',
        'powerid': '75',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "通知公告1",
                'powerid': '76',
                'children': {
                    'notice': {
                        'text': '通知公告列表1',
                        'url': '/notice/list.jsp',
                    }
                }
            },
            'menutop2': {
                'text': "短信平台",
                'powerid': '77',
                'children': {
                }
            },
            'menutop3': {
                'text': "实时邮箱",
                'powerid': '78',
                'children': {
                    'notice1': {
                        'text': '写信',
                        'url': '/workexchange/mailbox/write/write.jsp',
                    },
                    'notice2': {
                        'text': '看信',
                        'url': '/workexchange/mailbox/see/list.jsp',
                    },
                    'notice3': {
                        'text': '草稿箱',
                        'url': '/workexchange/mailbox/draft/list.jsp',
                    },
                    'notice4': {
                        'text': '已发送邮件',
                        'url': '/workexchange/mailbox/send/list.jsp',
                    },
                    'notice5': {
                        'text': '已删除邮件',
                        'url': '/workexchange/mailbox/delete/list.jsp',
                    },
                    'notice6': {
                        'text': '通讯录',
                        'url': '/workexchange/mailbox/directories/list.jsp',
                    },
//                    'notice7': {
//                        'text': '代表查询',
//                        'url': '/workexchange/write/list.jsp',
//                    }
                }
            },
            'menutop4': {
                'text': "内部消息",
                'powerid': '79',
                'children': {
                }
            }
        }
    },
    'top6': {
        'text': '双联服务',
        'powerid': '80',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "网上代表连络站",
                'powerid': '81',
                'children': {
                    'notice1': {
                        'text': '联络站管理',
                        'url': '/contactstation/list.jsp',
                        'powerid': '193',
                    },
                    'notice2': {
                        'text': '联络站信息动态',
                        'url': '/contactstation/my/list.jsp',
                        'powerid': '194',
                    },
                    'notice3': {
                        'text': '联络站站点管理',
                        'url': '/contactstation/substation/list.jsp',
                        'powerid': '251',
                    },
                }
            },
            'menutop2': {
                'text': "留言管理",
                'powerid': '246',
                'children': {
                    'notice1': {
                        'text': '留言管理',
                        'url': '/contactstation/leaveword/handle.jsp',
                        'powerid': '248',
                    },
                }
            },
            'menutop3': {
                'text': "代表留言审批",
                'powerid': '247',
                'children': {
                    'notice1': {
                        'text': '代表留言审批',
                        'url': '/contactstation/leaveword/objlist.jsp',
                        'powerid': '192',
                    },
                }
            },
            'menutop5': {
                'text': "工作动态",
                'powerid': '83',
                'children': {
                    'notice': {
                        'text': '工作动态',
                        'url': '/delegatexweb/workdynamics/list.jsp',
                    }
                }
            },
            'menutop6': {
                'text': "人大代表制度",
                'powerid': '84',
                'children': {
                    'notice': {
                        'text': '人大代表制度',
                        'url': '/delegatexweb/personsystem/list.jsp',
                    }
                }
            },
            'menutop4': {
                'text': "前台链接",
                'powerid': '249',
                'children': {
                    'notice1': {
                        'text': '前台链接',
                        'url': '/delegatexweb/gohere.jsp',
                        'powerid': '250',
                    },
                }
            },
        }
    },
    'top7': {
        'text': '代表网',
        'powerid': '82',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "工作动态",
                'powerid': '83',
                'children': {
                    'notice': {
                        'text': '工作动态',
                        'url': '/delegatexweb/workdynamics/list.jsp',
                    }
                }
            },
            'menutop2': {
                'text': "人大代表制度",
                'powerid': '84',
                'children': {
                    'notice': {
                        'text': '人大代表制度',
                        'url': '/delegatexweb/personsystem/list.jsp',
                    }
                }
            },
//            'menutop3': {
//                'text': "人大代表信息查看",
//                'powerid': '85',
//                'children': {
//                }
//            }
        }
    },
    'top8': {
        'text': '工作交流',
        'powerid': '86',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                },
            },
            'menutop1': {
                'text': "工作交流",
                'children': {
                    'notice': {
                        'text': '工作交流信息',
                        'url': '/poll/list.jsp',
                        'powerid': '87',
                    }
                }
            },
        }
    },
    'top9': {
        'text': '建议议案点评',
        'powerid': '88',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "建议议案点评",
                'children': {
                    'notice': {
                        'text': '点评信息',
                        'url': '/suggest/comment/list.jsp',
                    }
                }
            },
        }
    },
    'top10': {
        'text': '建议议案线索',
        'powerid': '89',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "建议议案线索",
                'children': {
                    'notice': {
                        'text': '线索信息',
                        'url': '/suggest/clue/list.jsp',
                    }
                }
            },
        }
    },
    'top11': {
        'text': '人大监督',
        'powerid': '204',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "议题管理",
                'powerid': '205',
                'children': {
                    'notice': {
                        'text': '议题管理',
                        'powerid': '206',
                        'url': '/supervision/topic/list.jsp',
                    },
                    'notice1': {
                        'text': '承办调研报告',
                        'url': '/supervision/topic/receipt/list.jsp?typeid=2',
                        'powerid': '207',
                    },
                    'notice2': {
                        'text': '承办整改方案',
                        'url': '/supervision/topic/receipt/list.jsp?typeid=7',
                        'powerid': '208',
                    },
                    'notice3': {
                        'text': '整改落实报告',
                        'url': '/supervision/topic/receipt/list.jsp?typeid=8',
                        'powerid': '209',
                    },
//                    'notice4': {
//                        'text': '抄送议题',
//                        'url': '/supervision/topic/zglsbg.jsp',
//                        'powerid': '210',
//                    },
                    'notice5': {
                        'text': '已归档议题',
                        'url': '/supervision/topic/ygdyt.jsp',
                        'powerid': '211',
                    },
                }
            },
            'menutop2': {
                'text': "执法检查",
                'powerid': '212',
                'children': {
                    'notice': {
                        'text': '执法检查管理',
                        'url': '/supervision/zhifajiancha/list.jsp?typeid=1',
                        'powerid': '213',
                    },
                    'notice1': {
                        'text': '承办执法检查',
                        'url': '/supervision/zhifajiancha/receipt/receipt_list.jsp?typeid=1',
                        'powerid': '237',
                    },
                    'notice2': {
                        'text': '已归档执法检查',
                        'url': '/supervision/zhifajiancha/file/file_list.jsp?typeid=1',
                        'powerid': '214',
                    },
                }
            },
            'menutop3': {
                'text': "听取和审议专题报告",
                'powerid': '215',
                'children': {
                    'notice': {
                        'text': '听取和审议专题报告',
                        'url': '/supervision/zhifajiancha/list.jsp?typeid=2',
                        'powerid': '216',
                    },
                    'notice1': {
                        'text': '承办听取和审议专题报告',
                        'url': '/supervision/zhifajiancha/receipt/receipt_list.jsp?typeid=2',
                        'powerid': '238',
                    },
                    'notice2': {
                        'text': '已归档听取和审议专题报告',
                        'url': '/supervision/zhifajiancha/file/file_list.jsp?typeid=2',
                        'powerid': '218',
                    },
                }
            },
            'menutop4': {
                'text': "专题询问",
                'powerid': '219',
                'children': {
                    'notice': {
                        'text': '专题询问',
                        'url': '/supervision/zhifajiancha/list.jsp?typeid=3',
                        'powerid': '210',
                    },
                    'notice1': {
                        'text': '承办专题询问',
                        'url': '/supervision/zhifajiancha/receipt/receipt_list.jsp?typeid=3',
                        'powerid': '239',
                    },
                    'notice2': {
                        'text': '已归档专题询问',
                        'url': '/supervision/zhifajiancha/file/file_list.jsp?typeid=3',
                        'powerid': '221',
                    },
                }
            },
            'menutop5': {
                'text': "工作评议",
                'powerid': '222',
                'children': {
                    'notice': {
                        'text': '工作评议',
                        'url': '/supervision/zhifajiancha/list.jsp?typeid=4',
                        'powerid': '223',
                    },
                    'notice1': {
                        'text': '承办工作评议',
                        'url': '/supervision/zhifajiancha/receipt/receipt_list.jsp?typeid=4',
                        'powerid': '240',
                    },
                    'notice2': {
                        'text': '已归档工作评议',
                        'url': '/supervision/zhifajiancha/file/file_list.jsp?typeid=4',
                        'powerid': '224',
                    },
                }
            },
            'menutop6': {
                'text': "质询和特定问题调查",
                'powerid': '234',
                'children': {
                    'notice': {
                        'text': '质询和特定问题调查',
                        'url': '/supervision/zhifajiancha/list.jsp?typeid=5',
                        'powerid': '235',
                    },
                    'notice1': {
                        'text': '承办质询和特定问题调查',
                        'url': '/supervision/zhifajiancha/receipt/receipt_list.jsp?typeid=5',
                        'powerid': '241',
                    },
                    'notice2': {
                        'text': '已归档质询和特定问题调查',
                        'url': '/supervision/zhifajiancha/file/file_list.jsp?typeid=5',
                        'powerid': '236',
                    },
                }
            }
        }
    },
    'top12': {
        'text': '规范性文件备案审查',
        'powerid': '252',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "规范性文件备案审查",
                'powerid': '253',
                'children': {
                    'notice': {
                        'text': '网上报备',
                        'powerid': '254',
                        'url': '/backups/list.jsp',
                    },
                    'notice1': {
                        'text': '备案',
                        'url': '/backups/list.jsp',
                        'powerid': '255',
                    },

                }
            },
        }
    },
    'top13': {
        'text': '官网后台',
        'powerid': '256',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "外网门户",
                'powerid': '257',
                'children': {
                    'notice1': {
                        'text': '重要活动发布管理',
                        'powerid': '258',
                        'url': '/website/list.jsp',
                    },
                    'notice7': {
                        'text': '通知公告发布管理',
                        'powerid': '292',
                        'url': '/website/notice/list.jsp',
                    },
                    'notice8': {
                        'text': '立法工作发布管理',
                        'powerid': '293',
                        'url': '/website/legiswork/list.jsp',
                    },
                    'notice9': {
                        'text': '乡镇动态发布管理',
                        'powerid': '294',
                        'url': '/website/townews/list.jsp',
                    },
                    'notice10': {
                        'text': '监督工作发布管理',
                        'powerid': '295',
                        'url': '/website/superon/list.jsp',
                    },
                    'notice11': {
                        'text': '代表工作发布管理',
                        'powerid': '296',
                        'url': '/website/reprwork/list.jsp',
                    },
                    'notice12': {
                        'text': '最新公告发布管理',
                        'powerid': '297',
                        'url': '/website/latment/list.jsp',
                    },
                    'notice13': {
                        'text': '决议决定发布管理',
                        'powerid': '298',
                        'url': '/website/resodec/list.jsp',
                    },
                    'notice14': {
                        'text': '选举任免发布管理',
                        'powerid': '299',
                        'url': '/website/elapprem/list.jsp',
                    },
                    'notice15': {
                        'text': '机关党建发布管理',
                        'powerid': '300',
                        'url': '/website/parbugov/list.jsp',
                    },
                    'notice16': {
                        'text': '汝州人大电子版发布管理',
                        'powerid': '301',
                        'url': '/website/elvrupec/list.jsp',
                    },
                    'notice2': {
                        'text': '会议内容发布管理',
                        'powerid': '259',
                        'url': '/website/meeting/list.jsp',
                    },
                    'notice3': {
                        'text': '公报内容发布管理',
                        'powerid': '260',
                        'url': '/website/bulletin/list.jsp',
                    },
                    'notice4': {
                        'text': '主任信息管理',
                        'powerid': '261',
                        'url': '/website/director/list.jsp',
                    },
                    'notice5': {
                        'text': '风景信息管理',
                        'powerid': '266',
                        'url': '/website/scenery/list.jsp',
                    },
                    'notice6': {
                        'text': '概况信息管理',
                        'powerid': '267',
                        'url': '/website/survey/list.jsp',
                    },
                    'notice20': {
                        'text': '专题集锦管理',
                        'powerid': '410',
                        'url': '/website/ztjj/list.jsp',
                    },
                }
            },
             'menutop2': {
                'text': "专题集锦与代表风采",
                'powerid': '356',
                'children': {
                    'notice': {
                        'text': '专题集锦添加',
                        'powerid': '357',
                        'url': '/wangzhan/add/addjijin.jsp',
                    },
                    'notice1': {
                        'text': '代表风采添加',
                        'url': '/wangzhan/add/addfengcai.jsp',
                        'powerid': '358',
                    },

                }
            },
        }
    },
    'top14' : {
        'text' : '信访工作系统',
        'powerid':'270',
        'children':{
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "业务受理",
                'powerid': '271',
                'children': {
                    'notice4': {
                        'text': '首页',
                        'powerid': '276',
                        'url': '/leavis/list.jsp',
                    },
                    'notice': {
                        'text': '来信登记',
                        'powerid': '272',
                        'url': '/leavis/letregtion/list.jsp',
                    },
                    'notice1': {
                        'text': '来访登记',
                        'powerid': '273',
                        'url': '/leavis/visregis/list.jsp',
                    },
                    'notice2': {
                        'text': '网上来信',
                        'powerid': '274',
                        'url': '/leavis/emailtion/list.jsp',
                    },
                    'notice3': {
                        'text': '上级转交件',
                        'powerid': '275',
                        'url': '/leavis/dohaovsup/list.jsp',
                    },
                }
            },
            'menutop2':{
                'text': "业务办理",
                'powerid': '277',
                'children':{
                    'notice': {
                        'text': '个人待办',
                        'powerid': '278',
                        'url': '/leavis/persontd/list.jsp',
                    },
                    'notice1': {
                        'text': '已办列表',
                        'powerid': '279',
                        'url': '/leavis/completlist/list.jsp',
                    },
                    'notice2': {
                        'text': '正办列表',
                        'powerid': '280',
                        'url': '/leavis/goinglist/list.jsp',
                    },
                    'notice3': {
                        'text': '待审核列表',
                        'powerid': '281',
                        'url': '/leavis/tbrevilist/list.jsp',
                    },
                }
            },
            'menutop3':{
                'text': "查询检索",
                'powerid': '282',
                'children':{
                    'notice': {
                        'text': '简单查询',
                        'powerid': '283',
                        'url': '/leavis/simplque/list.jsp',
                    },
                }
            }
        }
    },
    'top15': {
        'text': '立法工作平台',
        'powerid': '287',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "立法工作平台",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '立法规划',
                        'powerid': '289',
                        'url': '/legislative/Legislativeplanning/list.jsp',
                    },
                    'notice2': {
                        'text': '立法项目库',
                        'powerid': '290',
                        'url': '/legislative/LegislativeProjectLibrary/list.jsp',
                    },
                    'notice3': {
                        'text': '公开条例',
                        'powerid': '291',
                        'url': '/legislative/disclosureRegulations/list.jsp',
                    },
                }
            },
        }
    },
//    'top16':{
//        'text': '司法监督系统',
//        'powerid': '304',
//        'children':{
//            'menutop': {
//                'text': "功能导航",
//                'children': {
//                }
//            },
//            'menutop1':{
//                'text': "一年三问",
//                'powerid': '305',
//                'children': {
//                    'notice': {
//                        'text': '一年三问通知',
//                        'powerid': '306',
//                        'url': '/judicsuper/thrques/list.jsp',
//                    },
//                    'notice2': {
//                        'text': '年初安排',
//                        'powerid': '307',
//                        'url': '/judicsuper/arrbegye/list.jsp',
//                    },
//                    'notice3': {
//                        'text': '已归档年初安排',
//                        'powerid': '308',
//                        'url': '/judicsuper/',
//                    },
//                    'notice4': {
//                        'text': '监督管理',
//                        'powerid': '309',
//                        'url': '/judicsuper/',
//                    },
//                    'notice5': {
//                        'text': '年中进度报告',
//                        'powerid': '310',
//                        'url': '/judicsuper/',
//                    },
//                    'notice6': {
//                        'text': '年末结果报告',
//                        'powerid': '311',
//                        'url': '/judicsuper/',
//                    },
//                    'notice7': {
//                        'text': '已归档监督工作',
//                        'powerid': '312',
//                        'url': '/judicsuper/',
//                    },
//                    
//                }
//            }
//        }
//    },

    'top16':{
        'text': '司法监督系统',
        'powerid': '304',
        'children':{
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1':{
                'text': "信息征集管理",
                'powerid': '305',
                'children': {
                    'notice': {
                        'text': '司法监督议题征集',
                        'powerid': '306',
                        'url': '/judicsuper/colljusupis/list.jsp',
                    },
                    'notice2': {
                        'text': '述法线索征集',
                        'powerid': '307',
                        'url': '/judicsuper/collnarcl/list.jsp',
                    },
                    'notice3': {
                        'text': '办案质量检查线索征集',
                        'powerid': '308',
                        'url': '/judicsuper/collhaquin/list.jsp',
                    },
                    'notice4': {
                        'text': '座谈会',
                        'powerid': '314',
                        'url': '/judicsuper/forum/list.jsp',
                    },
                    'notice5': {
                        'text': '论证会',
                        'powerid': '315',
                        'url': '/judicsuper/demeeting/list.jsp',
                    },
                    'notice6': {
                        'text': '听证会',
                        'powerid': '316',
                        'url': '/judicsuper/hearing/list.jsp',
                    },
                    'notice7': {
                        'text': '群众意见',
                        'powerid': '317',
                        'url': '/judicsuper/opotmas/list.jsp',
                    }
                }
            },
            'menutop2':{
                'text': "司法监督管理",
                'powerid': '309',
                'children': {
                    'notice': {
                        'text': '司法监督管理',
                        'powerid': '310',
                        'url': '/judicsuper/judsupadm/list.jsp',
                    },
                    'notice2': {
                        'text': '已归档司法监督',
                        'powerid': '311',
                        'url': '/judicsuper/filjudsupadm/list.jsp',
                    },
                }
            },
            'menutop3':{
                'text': "精准信息推送",
                'powerid': '312',
                'children': {
                    'notice': {
                        'text': '精准信息推送',
                        'powerid': '323',
                        'url': '/judicsuper/thrques/list.jsp',
                    },
                    
                }
            },
            'menutop4':{
                'text': "规范性文件备案",
                'powerid': '350',
                'children': {
                    'notice': {
                        'text': '新增规范性文件',
                        'powerid': '355',
                        'url': '/judicsuper/jfxwjba/edit.jsp',
                    },
                    'notice2': {
                        'text': '查看规范性文件',
                        'powerid': '359',
                        'url': '/judicsuper/jfxwjba/list.jsp',
                    },
                    'notice3': {
                        'text': '待办理记录',
                        'powerid': '360',
                        'url': '/judicsuper/jfxwjba/list_1.jsp',
                    },
                    'notice4': {
                        'text': '驳回记录',
                        'powerid': '361',
                        'url': '/judicsuper/jfxwjba/list_2.jsp',
                    },
                }
            },
            
             'menutop5':{
                'text': "法治信息",
                'powerid': '403',
                'children': {
                    'notice': {
                        'text': '法律文书信息模块',
                        'powerid': '404',
                        'url': 'https://www.12309.gov.cn/12309/zjxflws/index.shtml',
                    },
                    'notice3': {
                        'text': '庭审直播与点播',
                        'powerid': '406',
                        'url': 'http://ts.hncourt.gov.cn/',
                    },
                    'notice2': {
                        'text': '司法公开及诉讼服务信息模块',
                        'powerid': '405',
                        'url': 'https://flk.npc.gov.cn/',
                    },
                    
                }
            },
        }
    },
    'top17': {
        'text': '选举任免系统',
        'powerid': '313',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "考核管理平台",
                'powerid': '322',
                'children': {
                    'notice': {
                        'text': '考生管理',
                        'powerid': '314',
                        'url': 'electionAppointmentAndRemovalSystem/candidateManagement/list.jsp',
                    },
                    'notice1': {
                        'text': '题库管理',
                        'powerid': '321',
                        'url': '/electionAppointmentAndRemovalSystem/questionBankManagement/list.jsp',
                    },
                    'notice2': {
                        'text': "考试管理",
                        'powerid': '315',
                        'url': '/electionAppointmentAndRemovalSystem/examManagement/list.jsp',
                    },
                    'notice3': {
                        'text': "试卷管理",
                        'powerid': '316',
                        'url': '/electionAppointmentAndRemovalSystem/testPaperManagement/list.jsp',
                    },
                    'notice4': {
                        'text': "题库文件",
                        'powerid': '317',
                        'url': '/electionAppointmentAndRemovalSystem/questionbankfile/list.jsp',
                    },
                }
            },
            'menutop2': {
                'text': "查询统计",
                'powerid': '318',
                'children': {
                    'notice': {
                        'text': '考试统计',
                        'powerid': '319',
                        'url': '/electionAppointmentAndRemovalSystem/examStatistics/list.jsp',
                    },
                    'notice2': {
                        'text': '考生统计',
                        'powerid': '320',
                        'url': '/electionAppointmentAndRemovalSystem/candidateStatistics/list.jsp',
                    },
                }
            },
        }
    },

}